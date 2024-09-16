package org.apiuniara.services;

import org.apiuniara.models.Aluno;
import org.apiuniara.repositories.AlunoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class AlunoService {
    @Autowired
    private AlunoRepository alunoRepository;
    public Aluno add(Aluno aluno){
        return alunoRepository.save(aluno);
    }
    public List<Aluno> get(){
        return alunoRepository.findAll();
    }
}
