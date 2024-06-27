# jsp_bulletin_with_serach_paging

### pageboard table create 문

```
 create table pageboard(
    -> id int auto_increment primary key,
    -> title varchar(100),
    -> name char(10),
    -> content text,
    -> pwd char(10),
    -> readnum int default 0,
    -> writeday date);

```

### writeOk.jsp 파일을 활용하여 데이터를 대량으로 insert 가능

### list4.jsp가 최종 조금씩 수정하며 업로드 예정

### lib 폴더에 들어가는 mysql java connector도 올려 두었음.

### eclipse 전체 폴더로는 git push 안됨
