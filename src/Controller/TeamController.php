<?php

namespace App\Controller;

use App\Entity\Teams;
use App\Form\TeamType;
use App\Repository\TeamsRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class TeamController extends AbstractController
{
    #[Route('/teams', name: 'app_teams')]
    public function index(TeamsRepository $teamsRepository): Response
    {
        $players = $teamsRepository->getPlayersTeam();
        foreach($players as $player) {
            $data[$player['team']['id']]['name'] = $player['team']['name'];
            $data[$player['team']['id']]['country'] = $player['team']['country'];
            $data[$player['team']['id']]['players'][] = $player['first_name'] . ' ' . $player['last_name'];
        }
        return $this->render('teams/index.html.twig', [
            'teams' => $data,
        ]);
    }

    #[Route('/teams/create', name: 'app_teams_create')]
    public function create(Request $request, EntityManagerInterface $entityManager): Response {
        $team = new Teams();
        $form = $this->createForm(TeamType::class, $team);
        $form->handleRequest($request);
        if ($form->isSubmitted() && $form->isValid()) {
            $team->setName($team->getName());
            $team->setCountry($team->getCountry());
            $team->setPurse($team->getPurse());
            $entityManager->persist($team);
            $entityManager->flush();
            $this->addFlash('success', 'The team is created');
            return $this->redirect($this->generateUrl('app_teams'));
        }

        return $this->render('teams/create.html.twig', [
            'form' => $form->createView()
        ]);
    }
}
