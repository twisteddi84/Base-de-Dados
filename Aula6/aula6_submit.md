# BD: Guião 6

## Problema 6.1

### *a)* Todos os tuplos da tabela autores (authors);

```
select * from authors
```

### *b)* O primeiro nome, o último nome e o telefone dos autores;

```
select au_fname, au_lname, phone from authors
```

### *c)* Consulta definida em b) mas ordenada pelo primeiro nome (ascendente) e depois o último nome (ascendente); 

```
select au_fname, au_lname, phone from authors order by au_fname asc, au_lname
```

### *d)* Consulta definida em c) mas renomeando os atributos para (first_name, last_name, telephone); 

```
select au_fname as first_name, au_lname as last_name, phone as telephone from authors order by au_fname asc, au_lname
```

### *e)* Consulta definida em d) mas só os autores da Califórnia (CA) cujo último nome é diferente de ‘Ringer’; 

```
select au_fname, au_lname, phone, state from authors  where state = 'CA' and au_lname != 'Ringer'  order by au_fname asc, au_lname 
```

### *f)* Todas as editoras (publishers) que tenham ‘Bo’ em qualquer parte do nome; 

```
select * from publishers where pub_name LIKE '%Bo%'
```

### *g)* Nome das editoras que têm pelo menos uma publicação do tipo ‘Business’; 

```
select distinct pub_name, type
from (publishers JOIN titles ON publishers.pub_id = titles.pub_id)
where type = 'business'
```

### *h)* Número total de vendas de cada editora; 

```
select publishers.pub_id, publishers.pub_name, nrtotal_por_pub=sum(qty)
from (publishers JOIN titles ON publishers.pub_id = titles.pub_id) JOIN sales on sales.title_id = titles.title_id
group by publishers.pub_id, publishers.pub_name
```

### *i)* Número total de vendas de cada editora agrupado por título; 

```
select titles.title_id, titles.title, tot_por_titulo =sum(qty)
from (publishers JOIN titles ON publishers.pub_id = titles.pub_id) JOIN sales on sales.title_id = titles.title_id
group by titles.title_id, titles.title
```

### *j)* Nome dos títulos vendidos pela loja ‘Bookbeat’; 

```
select sales.stor_id, stor_name , booknr=sum(qty) 
from (stores JOIN sales on stores.stor_id=sales.stor_id and stor_name='Bookbeat')
group by sales.stor_id, stor_name
```

### *k)* Nome de autores que tenham publicações de tipos diferentes; 

```
select authors.au_id, au_fname, au_lname
from ((authors join titleauthor on authors.au_id=titleauthor.au_id) join titles on titles.title_id = titleauthor.title_id)
group by authors.au_id, au_fname, au_lname
having count(DISTINCT [type]) > 1
```

### *l)* Para os títulos, obter o preço médio e o número total de vendas agrupado por tipo (type) e editora (pub_id);

```
select titles.pub_id, type, media_preco=avg(price), vendas_por_titulo=sum(qty)
from (titles join sales on titles.title_id=sales.title_id)
group by titles.pub_id, type
```

### *m)* Obter o(s) tipo(s) de título(s) para o(s) qual(is) o máximo de dinheiro “à cabeça” (advance) é uma vez e meia superior à média do grupo (tipo);

```
select type, max_adv=max(advance), avg_price=avg(price) from titles 
group by type
having max(advance) > 1.5 * avg(price)
```

### *n)* Obter, para cada título, nome dos autores e valor arrecadado por estes com a sua venda;

```
select titles.title_id, authors.au_fname, au_lname, total_arracadado_por_autor=price * qty from 
(((titles join titleauthor on titles.title_id=titleauthor.title_id) 
join authors on authors.au_id=titleauthor.au_id) 
join sales on sales.title_id=titles.title_id)
```

### *o)* Obter uma lista que incluía o número de vendas de um título (ytd_sales), o seu nome, a faturação total, o valor da faturação relativa aos autores e o valor da faturação relativa à editora;

```
select title, ytd_sales, facturacao=price*ytd_sales, auths_revenue=price*ytd_sales*royalty/100, publisher_revenue=price*ytd_sales-price*ytd_sales*royalty/100
from titles
where ytd_sales > 0
```

### *p)* Obter uma lista que incluía o número de vendas de um título (ytd_sales), o seu nome, o nome de cada autor, o valor da faturação de cada autor e o valor da faturação relativa à editora;

```
select title, ytd_sales, author=concat(au_fname, ' ', au_lname), auths_revenue=price*ytd_sales*royaltyper/100, publisher_revenue=price*ytd_sales-price*ytd_sales*royalty/100
from ((titles join titleauthor on titles.title_id=titleauthor.title_id) 
join authors on titleauthor.au_id=authors.au_id)
where ytd_sales > 0
```

### *q)* Lista de lojas que venderam pelo menos um exemplar de todos os livros;

```
select stores.stor_id, stor_name, count_tit=count(sales.title_id)
from ((stores join sales on stores.stor_id=sales.stor_id)
join titles on titles.title_id=sales.title_id)
group by stores.stor_id, stor_name
having count(sales.title_id)=(select count(*) from titles)
```

### *r)* Lista de lojas que venderam mais livros do que a média de todas as lojas;

```
select stores.stor_id, vendas_por_loja=sum(qty)
from stores join sales on stores.stor_id=sales.stor_id
group by stores.stor_id
having sum(qty) > (select distinct media_das_lojas=avg(sum(qty)) over()
					from stores join sales on stores.stor_id=sales.stor_id
					group by stores.stor_id)
```

### *s)* Nome dos títulos que nunca foram vendidos na loja “Bookbeat”;

```
select title from titles except(
	select title
	from ((stores join sales on sales.stor_id=stores.stor_id)
	join titles on titles.title_id=sales.title_id)
	where stor_name='Bookbeat'
)
```

### *t)* Para cada editora, a lista de todas as lojas que nunca venderam títulos dessa editora; 

```
select publishers.pub_id, stor_id 
from publishers, titles, sales except(

	select distinct publishers.pub_id, stor_id
	from ((publishers join titles on publishers.pub_id=titles.pub_id)
	join sales on titles.title_id=sales.title_id)
)
```

## Problema 6.2

### ​5.1

#### a) SQL DDL Script
 
[a) SQL DDL File](ex_6_2_1_ddl.sql "SQLFileQuestion")

#### b) Data Insertion Script

[b) SQL Data Insertion File](ex_6_2_1_data.sql "SQLFileQuestion")

#### c) Queries

##### *a)*

```
select employee.Fname,employee.Minit,employee.Lname,employee.Ssn,project.Pname From employee 
join works_on on employee.Ssn=works_on.Essn
join project on works_on.Pno=project.Pnumber
```

##### *b)* 

```
select funcionario.Ssn,funcionario.Fname,funcionario.Lname from employee as supervisor, employee as funcionario
where supervisor.Fname = 'Carlos' and supervisor.Minit ='D' and supervisor.Lname ='Gomes' and funcionario.Super_ssn=supervisor.Ssn
```

##### *c)* 

```
select project.Pname, sum(works_on.Hours) as horas_semana
from project, works_on
where works_on.Pno = project.Pnumber
group by project.Pname
```

##### *d)* 

```
select employee.Fname,employee.Lname from employee,works_on,project
where Dno = 3 and employee.Ssn = works_on.Essn and works_on.Pno = project.Pnumber and project.Pname = 'Aveiro Digital' and Hours>20
```

##### *e)* 

```
select Fname,Lname,Ssn from employee
left join works_on on Ssn = Essn
where Essn is null
```

##### *f)* 

```
select Dname,avg(Salary) as avg_Salary
from employee,department
where Sex = 'F'and Dno=department.Dnumber
group by department.Dname
```

##### *g)* 

```
select Ssn,Fname,Lname,count(dependent.Dependent_name) as dependentes from employee,dependent
where Ssn = Essn
group by employee.Ssn,employee.Fname,employee.Lname
having dependentes>2
```

##### *h)* 

```
select Fname,Lname,Ssn,Dnumber from employee,department
left join dependent on Ssn=dependent.Essn
where Ssn=department.Mgr_ssn and dependent.Dependent_name is null
```

##### *i)* 

```
select Fname,Lname,Ssn,Address from employee,works_on,project,dept_location
where employee.Ssn=works_on.Essn and works_on.Pno=project.Pnumber and Plocation = 'Aveiro'and employee.Dno=dept_location.Dnumber and Dlocation != 'Aveiro'
```

### 5.2

#### a) SQL DDL Script
 
[a) SQL DDL File](ex_6_2_2_ddl.sql "SQLFileQuestion")

#### b) Data Insertion Script

[b) SQL Data Insertion File](ex_6_2_2_data.sql "SQLFileQuestion")

#### c) Queries

##### *a)*

```
select fornecedor.nif,fornecedor.nome,fornecedor.endereco from fornecedor
left join encomenda on nif=fornecedor
where encomenda.numero is null
```

##### *b)* 

```
select numEnc,avg(unidades) as avg_unidades_produto from item
group by numEnc
```


##### *c)* 

```
SELECT avg(cast(produto_encomenda as float)) AS media_produto_encomenda
FROM (
    SELECT numEnc, COUNT(codProd) AS produto_encomenda
    FROM item
    GROUP BY numEnc
) as total_produtos
```


##### *d)* 

```
select fornecedor.nome,produto.codigo,produto.nome, sum(item.unidades) as soma_unidades from item,encomenda,fornecedor,produto
where encomenda.fornecedor = fornecedor.nif and encomenda.numero = item.numEnc and item.codProd=produto.codigo
group by fornecedor.nome,produto.codigo,produto.nome
```

### 5.3

#### a) SQL DDL Script
 
[a) SQL DDL File](ex_6_2_3_ddl.sql "SQLFileQuestion")

#### b) Data Insertion Script

[b) SQL Data Insertion File](ex_6_2_3_data.sql "SQLFileQuestion")

#### c) Queries

##### *a)*

```
select paciente.numUtente, paciente.nome from paciente
left join prescricao on paciente.numUtente = prescricao.numUtente
where prescricao.numPresc is null
```

##### *b)* 

```
select medico.especialidade,count(prescricao.numPresc) as numero_prescricoes from prescricao,medico
where prescricao.numMedico = medico.numSNS
group by medico.especialidade
```


##### *c)* 

```
select * from prescricao
where prescricao.dataProc is null
```


##### *d)* 

```
select farmaco.nome from farmaco
where farmaco.numRegFarm = 906 
except
select farmaco.nome from prescricao,presc_farmaco,farmaco
where prescricao.numPresc = presc_farmaco.numPresc and presc_farmaco.nomeFarmaco = farmaco.nome and farmaco.numRegFarm = 906
```

##### *e)* 

```
select farmacia,nome,count(nomeFarmaco) as farmaco_vendido_farmacia from prescricao,presc_farmaco,farmaceutica
where prescricao.dataProc is not null and presc_farmaco.numPresc = prescricao.numPresc and numReg=numRegFarm
group by farmacia,nome
```

##### *f)* 

```
select paciente.numUtente,paciente.nome from (select numUtente,count(numMedico) as numero_medico_diferentes from (select numUtente,numMedico,count(numMedico) as numero_prescricao_por_medico from prescricao group by numUtente,numMedico) as numero_presc_medico
group by numUtente
having numero_medico_diferentes>1) as paciente_medicos_diferentes
join paciente on paciente_medicos_diferentes.numUtente = paciente.numUtente
```
