package org.apiuniara.controllers;

import io.swagger.v3.oas.annotations.parameters.RequestBody;
import org.apiuniara.models.Reserva;
import org.apiuniara.services.ReservaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
public class ReservaController {

    @Autowired
    private ReservaService reservaService;

    @CrossOrigin
    @GetMapping("/reservas")
    public List<Reserva> findAll() {
        return reservaService.findAll();
    }

    @CrossOrigin
    @PostMapping("/reservas")
    public Reserva save(@RequestBody Reserva reserva) {
        return reservaService.save(reserva);
    }

    @CrossOrigin
    @GetMapping("/reservas/{id}")
    public Optional<Reserva> findById(@RequestParam int id) {
        return reservaService.findById(id);
    }

    @CrossOrigin
    @DeleteMapping("/reservas/{id}")
    public void delete(@RequestParam int id){
        reservaService.deleteById(id);
    }
}
