# BD: Guião 8


## ​8.1. Complete a seguinte tabela.
Complete the following table.

| #    | Query                                                                                                      | Rows  | Cost  | Pag. Reads | Time (ms) | Index used                        | Index Op.               | Discussion |
| :--- | :--------------------------------------------------------------------------------------------------------- | :---- | :---- | :--------- | :-------- | :---------                        | :-------------------    | :--------- |
| 1    | SELECT * from Production.WorkOrder                                                                         | 72591 | 0.080 | 552        | 545       | PK_WorkOrder_WorkOrderID          | Clustered Index Scan    |            |
| 2    | SELECT * from Production.WorkOrder where WorkOrderID=1234                                                  | 1     | 0.000 | 26         | 25        | PK_WorkOrder_WorkOrderID          | Clustered Index Scan    |            |
| 3.1  | SELECT * FROM Production.WorkOrder WHERE WorkOrderID between 10000 and 10010                               | 11    | 0.000 | 26         | 56        | PK_WorkOrder_WorkOrderID          | Clustered Index Scan    |            |
| 3.2  | SELECT * FROM Production.WorkOrder WHERE WorkOrderID between 1 and 72591                                   | 72591 | 0.080 | 556        | 481       | PK_WorkOrder_WorkOrderID          | Clustered Index Scan    |            |
| 4    | SELECT * FROM Production.WorkOrder WHERE StartDate = '2007-06-25'                                          | 0     | 0.080 | 1725       | 54        | PK_WorkOrder_WorkOrderID          | Clustered Index Scan    |            |
| 5    | SELECT * FROM Production.WorkOrder WHERE ProductID = 757                                                   | 9     | 0.000 | 46         | 49        | IX_WorkOrder_ProductID            | Clustered Index Scan + NonClustered Index Scan |            |
| 6.1  | SELECT WorkOrderID, StartDate FROM Production.WorkOrder WHERE ProductID = 757                              | 9     | 0.000 | 46         | 36        | IX_WorkOrder_ProductID            | Clustered Index Scan + NonClustered Index Scan |            |
| 6.2  | SELECT WorkOrderID, StartDate FROM Production.WorkOrder WHERE ProductID = 945                              | 1105  | 0.000 | 556        | 43        | PK_WorkOrder_WorkOrderID          | Clustered Index Scan    |            |
| 6.3  | SELECT WorkOrderID FROM Production.WorkOrder WHERE ProductID = 945 AND StartDate = '2012-05-09'            | 1     | 0.080 | 558        | 7         | PK_WorkOrder_WorkOrderID          | Clustered Index Scan    |            |
| 7    | SELECT WorkOrderID, StartDate FROM Production.WorkOrder WHERE ProductID = 945 AND StartDate = '2012-05-09' | 1     | 0.080 | 558        | 7         | PK_WorkOrder_WorkOrderID          | Clustered Index Scan    |            |
| 8    | SELECT WorkOrderID, StartDate FROM Production.WorkOrder WHERE ProductID = 945 AND StartDate = '2012-05-09' | 1     | 0.080 | 558        | 7         | PK_WorkOrder_WorkOrderID          | Clustered Index Scan    |            |

## ​8.2.

### a)

```
CREATE UNIQUE CLUSTERED INDEX ridIndex ON mytemp(rid);
```

### b)

```
A percentagem de fragmentação dos índices: 99,03 %
Ocupação das páginas dos índices: 68,41 %

```

### c)

```
-- CREATE UNIQUE CLUSTERED INDEX  ridIndex_c1 ON mytemp(rid) WITH (FILLFACTOR = 65, PAD_INDEX = ON)
-- Tempo: 1:55 

-- CREATE UNIQUE CLUSTERED INDEX  ridIndex_c1 ON mytemp(rid) WITH (FILLFACTOR = 80, PAD_INDEX = ON)
-- Tempo: 1:54

-- CREATE UNIQUE CLUSTERED INDEX  ridIndex_c1 ON mytemp(rid) WITH (FILLFACTOR = 90, PAD_INDEX = ON)
-- Tempo: 1:58
```

### d)

```
ALTER TABLE mytemp ALTER COLUMN rid BIGINT IDENTITY (1, 1) NOT NULL
```

### e)

```
CREATE NONCLUSTERED INDEX at1Index ON mytemp(at1);
CREATE NONCLUSTERED INDEX at2Index ON mytemp(at2);
CREATE NONCLUSTERED INDEX at3Index ON mytemp(at3);
CREATE NONCLUSTERED INDEX lixoIndex ON mytemp(lixo);
-- Os tempos aumentaram consideravelmente uma vez que a operação está a ser realizada para cada indice criado
```

## ​8.3.

```
-- i
CREATE UNIQUE CLUSTERED INDEX ssnIndex ON dbo.Company.Employee(ssn);

-- ii
CREATE NONCLUSTERED INDEX namesIndex ON Employee(Fname,Lname);

-- iii
CREATE NONCLUSTERED INDEX depEmpIndex ON Employee(Dno);
CREATE UNIQUE CLUSTERED INDEX depIndex ON Department(Dnumber);

-- iv
CREATE UNIQUE CLUSTERED INDEX ssnIndex ON Employee(ssn);
CREATE UNIQUE CLUSTERED INDEX worksOnIndex ON Works_on(Essn,Pno);
CREATE NONCLUSTERED INDEX projIndex ON Project(Pnumber);

-- v
CREATE UNIQUE CLUSTERED INDEX DependentIndex ON Dependent(Essn,Dependent_name);

-- vi
CREATE NONCLUSTERED INDEX projIndex ON Project(Dnum);
CREATE UNIQUE CLUSTERED INDEX depIndex ON Department(Dnumber);

CREATE CLUSTERED INDEX dependent ON dependent(Essn);

--vi)
CREATE INDEX DNum ON project(Dnum);
```
