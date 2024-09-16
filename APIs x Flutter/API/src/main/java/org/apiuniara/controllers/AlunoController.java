package org.apiuniara.controllers;

import org.apiuniara.models.Aluno;
import org.apiuniara.services.AlunoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
@RestController
public class AlunoController {

    private static final String API_ENDPOINT = "apiuniara/api/v1/aluno";

    @Autowired
    private AlunoService alunoService;

    @CrossOrigin
    @PostMapping(API_ENDPOINT)
    public Aluno add(@RequestBody Aluno aluno){
        return alunoService.add(aluno);
    }

    @CrossOrigin
    @GetMapping(API_ENDPOINT)
    public List<Aluno> get(){
        return alunoService.get();
    }
}
