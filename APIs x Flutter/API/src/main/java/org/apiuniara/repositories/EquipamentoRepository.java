package org.apiuniara.repositories;

import org.apiuniara.models.Aluno;
import org.apiuniara.models.Equipamento;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface EquipamentoRepository extends JpaRepository<Equipamento, Integer> {
}
