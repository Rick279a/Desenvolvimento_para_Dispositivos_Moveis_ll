package org.apiuniara.services;

import org.apiuniara.models.Equipamento;
import org.apiuniara.repositories.EquipamentoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.time.LocalDateTime;
import java.util.List;

@Service
public class EquipamentoService {

    @Autowired
    private EquipamentoRepository equipamentoRepository;

    public List<Equipamento> findAll() {
        return equipamentoRepository.findAll();
    }

    public Equipamento save(Equipamento equipamento) {
        return equipamentoRepository.save(equipamento);
    }

    public void reserve(int id) {
        Equipamento equipamento = equipamentoRepository.findById(id).get();
        equipamento.setDisponivel(false);
        equipamento.setDataRetirada(LocalDateTime.now()); 
        equipamentoRepository.save(equipamento);
    }

    public void liberar(int id) {
        Equipamento equipamento = equipamentoRepository.findById(id).get();
        equipamento.setDisponivel(true);
        equipamento.setDataRetirada(null); 
        equipamentoRepository.save(equipamento);
    }
}
