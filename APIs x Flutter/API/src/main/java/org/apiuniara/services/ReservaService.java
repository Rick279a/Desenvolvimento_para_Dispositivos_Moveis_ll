package org.apiuniara.services;

import org.apiuniara.models.Reserva;
import org.apiuniara.repositories.ReservaRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
public class ReservaService {

    @Autowired
    private ReservaRepository reservaRepository;

    public List<Reserva> findAll() {
        return reservaRepository.findAll();
    }

    public Reserva save(Reserva reserva) {
        return reservaRepository.save(reserva);
    }

    public Optional<Reserva> findById(int id) {
        return reservaRepository.findById(id);
    }

    public void deleteById(int id){
        reservaRepository.deleteById(id);
    }



}
