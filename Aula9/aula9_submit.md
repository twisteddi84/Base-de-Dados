# BD: Guião 9


## ​9.1
 
### *a)*

```
CREATE PROC remover_funcionario @ssn char(9)
AS
BEGIN

  -- Remover entradas na tabela works_on
  DELETE FROM works_on WHERE Essn = @ssn;

  UPDATE employee set Super_ssn = NULL where Super_ssn = @ssn;

  -- Remover dependentes
  DELETE FROM dependent WHERE Essn = @ssn;

  -- Remover funcionário
  DELETE FROM employee WHERE Ssn = @ssn;

END;
```

### *b)* 

```
CREATE PROC funcionario_mais_antigo
AS
BEGIN
	SELECT TOP 1 Mgr_ssn, DATEDIFF(YEAR, Mgr_start_date, GETDATE()) AS anos_desde_inicio 
	FROM department 
	WHERE Mgr_start_date IS NOT NULL 
	ORDER BY Mgr_start_date ASC;
END;
```

### *c)* 

```
CREATE TRIGGER tr_no_duplicate_mgr
ON department
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS (SELECT Mgr_ssn
               FROM department
               WHERE Mgr_ssn IN (SELECT Mgr_ssn
                                 FROM inserted)
               GROUP BY Mgr_ssn
               HAVING COUNT(*) > 1)
    BEGIN
        RAISERROR ('O funcionário já é gerente de outro departamento.', 16, 1)
        ROLLBACK TRANSACTION
    END
END;
```

### *d)* 

```
CREATE TRIGGER tr_salary_check
ON employee
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS (SELECT *
               FROM employee e
               INNER JOIN department d ON e.Dno = d.Dnumber
               INNER JOIN employee mgr ON d.Mgr_ssn = mgr.Ssn
               WHERE e.Salary > mgr.Salary)
    BEGIN
        UPDATE e
        SET e.Salary = mgr.Salary - 1
        FROM employee e
        INNER JOIN department d ON e.Dno = d.Dnumber
        INNER JOIN employee mgr ON d.Mgr_ssn = mgr.Ssn
        WHERE e.Salary > mgr.Salary
        
        PRINT 'O salário do funcionário foi ajustado.'
    END
END;
```

### *e)* 

```
CREATE FUNCTION udf_projetos_funcionario (@ssn CHAR(9))
RETURNS TABLE
AS
RETURN
(
    SELECT p.Pname, p.Plocation, w.Essn
    FROM project AS p
    INNER JOIN works_on AS w ON p.Pnumber = w.Pno
    WHERE w.Essn = @ssn
);
```

### *f)* 

```
CREATE FUNCTION udf_departamento_supMedia (@dno INT)
RETURNS TABLE
AS
RETURN
(
	SELECT * FROM employee 
	WHERE employee.Salary > (
	SELECT AVG(employee.Salary) AS media FROM employee WHERE employee.Dno = @dno)
);
```

### *g)* 

```
CREATE FUNCTION dbo.projectBudgets(@dno INT)
RETURNS @projectBudgets TABLE (ProjectName VARCHAR(50), ProjectNumber INT, MonthlyLaborBudget DECIMAL(18,2), CumulativeBudget DECIMAL(18,2))
AS
BEGIN
    DECLARE @projectName VARCHAR(50)
    DECLARE @projectNumber INT
    DECLARE @monthlyLaborBudget DECIMAL(18,2)
    DECLARE @cumulativeBudget DECIMAL(18,2)
    DECLARE @runningTotal DECIMAL(18,2) = 0
    
    DECLARE projectCursor CURSOR FOR
        SELECT p.pname, p.pnumber
        FROM project p
        WHERE p.dnum = @dno
    
    OPEN projectCursor
    FETCH NEXT FROM projectCursor INTO @projectName, @projectNumber
    
    WHILE @@FETCH_STATUS = 0
    BEGIN
        SET @monthlyLaborBudget = (SELECT SUM(w.hours * e.salary / 160)
                                   FROM works_on w
                                   JOIN employee e ON w.essn = e.ssn
                                   WHERE w.pno = @projectNumber)
        SET @runningTotal = @runningTotal + @monthlyLaborBudget
        SET @cumulativeBudget = @runningTotal
        
        INSERT INTO @projectBudgets (ProjectName, ProjectNumber, MonthlyLaborBudget, CumulativeBudget)
        VALUES (@projectName, @projectNumber, @monthlyLaborBudget, @cumulativeBudget)
        
        FETCH NEXT FROM projectCursor INTO @projectName, @projectNumber
    END
    
    CLOSE projectCursor
    DEALLOCATE projectCursor
    
    RETURN
END
```

### *h)* 

```
--After
go
CREATE TRIGGER tr_department_deleted
ON department
AFTER DELETE
AS
BEGIN
  IF (EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'department_deleted'))
  BEGIN
    INSERT INTO department_deleted
    SELECT *
    FROM deleted;
  END
  ELSE
  BEGIN
    SELECT *
    INTO department_deleted
    FROM deleted;
  END
END
go
--Instead
go
CREATE TRIGGER tr_department_deleted_instead_of
ON department
INSTEAD OF DELETE
AS
BEGIN
  IF (EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'department_deleted'))
  BEGIN
    INSERT INTO department_deleted
    SELECT *
    FROM deleted;
  END
  ELSE
  BEGIN
    SELECT *
    INTO department_deleted
    FROM deleted;
  END

  DELETE d
  FROM department d
  JOIN deleted del ON d.dnumber = del.dnumber;
END
```

### *i)* 

```
As principais vantagens das stored procedures são:

Melhoria do desempenho: uma stored procedure pode ser compilada e armazenada em cache.
Controle de segurança: é possível controlar o acesso às informações e as operações que podem ser realizadas.
Facilidade de manutenção: uma stored procedure pode ser atualizada e testada independentemente de outras partes da aplicação.
Maior escalabilidade: permite que uma aplicação seja escalável.

As principais vantagens das UDFs são:

Modularidade: as UDFs permitem a criação de funções personalizadas que podem ser usadas em várias partes da aplicação.
Facilidade de utilização: as UDFs podem ser facilmente integradas em instruções SELECT, UPDATE, INSERT e DELETE.
Reutilização de código: como as UDFs são funções personalizadas, é possível reutilizar o código em diferentes situações.
Performance: as UDFs permitem a criação de cálculos complexos que podem ser executados de forma eficiente.

Uma stored procedure é ideal para realizar atualizações em lote, enquanto uma UDF é mais adequada para operações de cálculo.
```
