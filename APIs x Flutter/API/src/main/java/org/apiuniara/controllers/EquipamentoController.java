package org.apiuniara.controllers;

import org.apiuniara.models.Equipamento;
import org.apiuniara.services.EquipamentoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
public class EquipamentoController {

    @Autowired
    private EquipamentoService equipamentoService;

    @CrossOrigin
    @GetMapping("/equipamentos")
    public List<Equipamento> findAll(){
        return equipamentoService.findAll();
    }

    @CrossOrigin
    @PostMapping("/equipamentos")
    public Equipamento save(@RequestBody Equipamento equipamento) {
        return equipamentoService.save(equipamento);
    }

    @CrossOrigin
    @PostMapping("/equipamentos/{equipamentoId}/reservar")
    public void reserve(@PathVariable int equipamentoId) {
        equipamentoService.reserve(equipamentoId);
    }

    @CrossOrigin
    @PostMapping("/equipamentos/{equipamentoId}/liberar")
    public void liberar(@PathVariable int equipamentoId) {
        equipamentoService.liberar(equipamentoId);
    }
}
