package org.apiuniara.repositories;

import org.apiuniara.models.Aluno;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.ArrayList;
import java.util.List;

@Repository
public interface AlunoRepository extends JpaRepository<Aluno, Integer> {
/*
    private static List<Aluno> lst = new ArrayList<>();

    public Aluno add(Aluno aluno) {
        lst.add(aluno);
        return aluno;
    }
    public List<Aluno> getAll(){
        return lst;
    }

 */
}
