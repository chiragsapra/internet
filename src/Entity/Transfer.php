<?php

namespace App\Entity;

use App\Repository\TransferRepository;
use Doctrine\DBAL\Types\Types;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: TransferRepository::class)]
class Transfer
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\Column(nullable: true)]
    private ?int $old_team_id = null;

    #[ORM\Column(nullable: true)]
    private ?int $new_team_id = null;

    #[ORM\Column]
    private ?int $player_id = null;

    #[ORM\Column(type: Types::DATETIME_MUTABLE)]
    private ?\DateTimeInterface $created = null;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getOldTeamId(): ?int
    {
        return $this->old_team_id;
    }

    public function setOldTeamId(?int $old_team_id): self
    {
        $this->old_team_id = $old_team_id;

        return $this;
    }

    public function getNewTeamId(): ?int
    {
        return $this->new_team_id;
    }

    public function setNewTeamId(?int $new_team_id): self
    {
        $this->new_team_id = $new_team_id;

        return $this;
    }

    public function getPlayerId(): ?int
    {
        return $this->player_id;
    }

    public function setPlayerId(int $player_id): self
    {
        $this->player_id = $player_id;

        return $this;
    }

    public function getCreated(): ?\DateTimeInterface
    {
        return $this->created;
    }

    public function setCreated(\DateTimeInterface $created): self
    {
        $this->created = $created;

        return $this;
    }
}
