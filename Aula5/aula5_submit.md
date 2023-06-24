# BD: Guião 5


## ​Problema 5.1
 
### *a)*

```
(π Ssn,Fname,Lname (employee)) ⨝ project 
```


### *b)* 

```
π Fname,Lname,Super_ssn (employee) ⨝ Super_ssn=supervisor.Ssn (ρ supervisor (π Ssn (σ (Fname='Carlos' and Minit='D' and Lname='Gomes') (employee))))
```


### *c)* 

```
π Pname,THours (γ Pnumber,Pname; sum(Hours) -> THours (ρ hours_project (π Pno,Hours (works_on) ⨝ works_on.Pno = project.Pnumber (π Pnumber,Pname (project)))))
```


### *d)* 

```
π Fname,Lname (σ Pname='Aveiro Digital' and Hours>20 ((π Fname,Lname,Ssn (σ Dno=3 (employee)) ⨝ Ssn = works_on.Essn (π Essn,Hours,Pno (works_on))) ⨝ Pno=project.Pnumber (π Pnumber,Pname (project))))
```


### *e)* 

```
π Fname,Lname ((ρ nao_projeto (π Ssn (employee)) - (π Essn (works_on))) ⨝ nao_projeto.Ssn=employee.Ssn (employee))
```


### *f)* 

```
π Dname,Average_Salary (γ Dno,Dname; avg(Salary)->Average_Salary (σ Sex='F' (employee ⨝ Dno=department.Dnumber (department))))
```


### *g)* 

```
π Fname,Lname,Ssn,count_Depname (employee ⨝ Ssn = Essn (σ count_Depname>2 (γ Essn;count(Dependent_name)->count_Depname (dependent))))
```


### *h)* 

```
σ Essn = null (π Fname,Lname,Ssn (employee) ⨝ Ssn = Mgr_ssn (department) ⟕ Ssn = dependent.Essn (dependent))
```


### *i)* 

```
σ Total_Projetos>0 (γ Fname,Lname,Address;count(Pno)->Total_Projetos (σ Dlocation ≠ 'Aveiro' ((σ Plocation = 'Aveiro' ((employee ⨝ employee.Ssn=works_on.Essn (works_on)) ⨝ Pno = project.Pnumber (project))) ⨝ employee.Dno = Dnumber (dept_location))))
```


## ​Problema 5.2

### *a)*

```
fornecedor ⨝ fornecedor.nif=nif_sem_encomenda.nif (ρ nif_sem_encomenda ((π nif (fornecedor)) - (π fornecedor (encomenda))))
```

### *b)* 

```
π codigo,nome,media_unidades ((produto) ⨝ produto.codigo=codProd (γ codProd; avg(unidades)->media_unidades (item)))
```


### *c)* 

```
γ avg(num_produto_Encomenda)-> media_produto_encomenda (γ numEnc; count(numEnc)->num_produto_Encomenda (item))
```


### *d)* 

```
π fornecedor.nif,fornecedor.nome,encomenda.numero,produto.codigo, produto.nome, item.unidades (((π fornecedor.nif,fornecedor.nome,encomenda.numero (encomenda ⨝ fornecedor=nif (fornecedor))) ⨝ numero = item.numEnc (item)) ⨝ codProd = produto.codigo (produto))
```


## ​Problema 5.3

### *a)*

```
σ prescricao.numUtente = Null (paciente ⟕ paciente.numUtente=prescricao.numUtente (prescricao))
```

### *b)* 

```
π codigo,nome,media_unidades ((produto) ⨝ produto.codigo=codProd (γ codProd; avg(unidades)->media_unidades (item)))
```


### *c)* 

```
γ prescricao.farmacia; count(prescricao.farmacia)->count_presc_farm (prescricao ⨝ prescricao.farmacia=farmacia.nome (farmacia))
```


### *d)* 

```
π presc_farmaco.nomeFarmaco,nr.numReg (γ presc_farmaco.nomeFarmaco, nr.numReg ;count(presc_farmaco.nomeFarmaco)->not_registed (σ nr.numReg=Null (presc_farmaco ⟕ presc_farmaco.numRegFarm=nr.numReg (ρ nr (σ(numReg=906) (farmaceutica))))))
```

### *e)* 

```
γ farmacia,nome;count(nomeFarmaco)->farmaco_vendido_farmacia (farmaceutica ⨝ numReg=numRegFarm (presc_farmaco ⨝ presc_farmaco.numPresc = prescricao_processada.numPresc (ρ prescricao_processada (σ dataProc≠null (prescricao)))))
```

### *f)* 

```
σ quantidade_medicos_diferentes>1 (paciente ⨝ paciente.numUtente=prescricao.numUtente (γ numUtente;count(numUtente)-> quantidade_medicos_diferentes (γ numUtente,numMedico;count(numMedico)->numero_prescricao_por_medico (prescricao))))
```
