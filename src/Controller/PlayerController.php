<?php

namespace App\Controller;

use App\Entity\Players;
use App\Entity\Teams;
use App\Entity\Transfer;
use App\Form\PlayersType;
use App\Form\TransferType;
use App\Repository\PlayersRepository;
use App\Repository\TeamsRepository;
use App\Repository\TransferRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;


class PlayerController extends AbstractController
{
    #[Route('/player', name: 'app_player')]
    public function index(PlayersRepository $playersRepository): Response
    {
        $players = $playersRepository->findBy(['is_available' => 1]);
        return $this->render('player/index.html.twig', [
            'players' => $players,
        ]);
    }

    #[Route('/owned', name: 'app_owned')]
    public function owned(PlayersRepository $playersRepository): Response {
        $user = $this->getUser();
        $team = $user->getTeam();
        $players = $playersRepository->findBy(['team' => $team]);
        return $this->render('player/owned.html.twig', [
            'players' => $players,
        ]);
    }

    #[Route('/transfer', name: 'app_transfer')]
    public function transfer(TransferRepository $transferRepository, PlayersRepository $playersRepository, TeamsRepository $teamsRepository): Response {
        $data = $transferRepository->findAll();
        foreach ($data as $key => $val) {
            $result[$key]['name'] = $playersRepository->find($val->getPlayerId())->getFirstName() . ' ' . $playersRepository->find($val->getPlayerId())->getLastName();
            $result[$key]['old'] = !empty($val->getOldTeamId()) ? $teamsRepository->find($val->getOldTeamId())->getName() : '';
            $result[$key]['new'] = !empty($val->getNewTeamId()) ? $teamsRepository->find($val->getNewTeamId())->getName() : '';
            $result[$key]['when'] = $val->getCreated()->format('d-m-Y H:i');
        }
        return $this->render('player/transfer.html.twig', [
            'data' => $result,
        ]);
    }

    #[Route('/player/create', name: 'app_player_create')]
    public function create(Request $request, EntityManagerInterface $entityManager): Response {
        $player = new Players();
        $form = $this->createForm(PlayersType::class, $player);
        $form->handleRequest($request);
        if ($form->isSubmitted() && $form->isValid()) {
            $player->setFirstName($player->getFirstName());
            $player->setLastName($player->getLastName());
            $entityManager->persist($player);
            $entityManager->flush();
            $this->addFlash('success', 'The Player is addded');
            return $this->redirect($this->generateUrl('app_player_create'));
        }

        return $this->render('player/create.html.twig', [
            'form' => $form->createView()
        ]);
    }

    #[Route('/player/buy/{id}', name: 'app_player_buy')]
    public function buy($id, Request $request, EntityManagerInterface $entityManager, PlayersRepository $playersRepository, TeamsRepository $teamsRepository): Response {
        $transfer = new Transfer();
        $user = $this->getUser();
        $players = $playersRepository->find($id);
        $form = $this->createForm(TransferType::class, $transfer);
        $form->handleRequest($request);
        // $player = $entityManager->find(Players::class, $id);
        if ($form->get('cancel')->isClicked()) {
            $this->addFlash('success', 'Operation Cancelled');
            return $this->redirect($this->generateUrl('app_player'));
        }
        if ($form->isSubmitted()) {
            $team = $user->getTeam();
            $teamPurse = $teamsRepository->find($team->getId())->getPurse();
            $price = $players->getPrice();
            $oldTeamId = $players->getTeam();
            if ($teamPurse > $price) {
                $remaining = $teamPurse - $price;
                $player = $entityManager->find(Players::class, $id);
                $player->setisAvailable(0);
                $player->setTeam($team);
                $team = $entityManager->find(Teams::class, $team->getId());
                $team->setPurse($remaining);
                $transfer->setOldTeamId($oldTeamId);
                $transfer->setNewTeamId($team->getId());
                $transfer->setPlayerId($id);
                $transfer->setCreated(date_create());
                $entityManager->persist($player);
                $entityManager->persist($team);
                $entityManager->persist($transfer);
                $entityManager->flush();
                $this->addFlash('success', 'The Player ' . $player->getFirstName() . ' ' . $player->getLastName() . ' is addded to your team');
                return $this->redirect($this->generateUrl('app_player'));
            } else {
                $this->addFlash('success', 'You dont have sufficient balance to buy this player.');
                return $this->redirect($this->generateUrl('app_player'));
            }
        }
        $players = $playersRepository->find($id);
        $name = $players->getFirstName() . ' ' . $players->getLastName();
        return $this->render('player/buy.html.twig', [
            'form' => $form->createView(),
            'name' => $name,
            'price' => $players->getPrice(),
        ]);
    }


    #[Route('/player/sell/{id}', name: 'app_player_sell')]
    public function sell($id, Request $request, EntityManagerInterface $entityManager, PlayersRepository $playersRepository, TeamsRepository $teamsRepository): Response {
        $transfer = new Transfer();
        $user = $this->getUser();
        $players = $playersRepository->find($id);
        $form = $this->createForm(TransferType::class, $transfer);
        $form->handleRequest($request);
        if ($form->get('cancel')->isClicked()) {
            $this->addFlash('success', 'Operation Cancelled');
            return $this->redirect($this->generateUrl('app_player'));
        }
        if ($form->isSubmitted()) {
            $team = $user->getTeam();
            $teamPurse = $teamsRepository->find($team->getId())->getPurse();
            $price = $players->getPrice();
            $oldTeamId = $players->getTeam()->getId();
            $add = $teamPurse + $price;
            $player = $entityManager->find(Players::class, $id);
            $player->setisAvailable(1);
            $player->setTeam(NULL);
            $team = $entityManager->find(Teams::class, $team->getId());
            $team->setPurse($add);
            $transfer->setOldTeamId($oldTeamId);
            $transfer->setNewTeamId(NULL);
            $transfer->setPlayerId($id);
            $transfer->setCreated(date_create());
            $entityManager->persist($player);
            $entityManager->persist($team);
            $entityManager->persist($transfer);
            $entityManager->flush();
            $this->addFlash('success', 'The Player ' . $player->getFirstName() . ' ' . $player->getLastName() . ' is addded to sell list');
            return $this->redirect($this->generateUrl('app_player'));
        }
        $players = $playersRepository->find($id);
        $name = $players->getFirstName() . ' ' . $players->getLastName();
        return $this->render('player/sell.html.twig', [
            'form' => $form->createView(),
            'name' => $name,
        ]);
    }

}
