import random

first = '김이박정윤최장한오우배변곽공류홍표조주도신은혜선명진수국종경'
second = '김이박정윤최장한오우배변곽공류홍표조주도신은혜선명진수국종경'
third = '김이박정윤최장한오우배변곽공류홍표조주도신은혜선명진수국종경'
lectureList = ['데이터베이스설계', '자료구조론', '알고리즘설계', '컴퓨터그래픽스설계', '오퍼레이팅설계', '고급대학영어', '컴퓨터네트워크']
base = "INSERT INTO STUDENT (id, Fname, Lname, lecture) VALUES "
IdList = []

sql = []
for i in range(100000):
    if i % 10000 == 0:
        print(i)
    f_idx = random.randint(0, len(first)-1)
    s_idx = random.randint(0, len(first)-1)
    t_idx = random.randint(0, len(first)-1)
    lec_idx = random.randint(0, len(lectureList)-1)

    Id = random.randint(11111111, 99999999)
    while Id in IdList:
        Id = random.randint(11111111, 99999999)
    IdList.append(Id)

    Fname = second[s_idx] + third[t_idx]
    Lname = first[f_idx]

    lecture = lectureList[lec_idx]

    query = base + '("'+ str(Id) + '","' + Fname + '", "' + Lname + '", "'+ lecture + '");\n'

    sql.append(query)

f = open('week9_step2.sql', 'w', encoding="UTF-8")
# 사용할 DB 이름
f.writelines("USE week9_assignment_12181763;\n")
for i, s in enumerate(sql):
    f.writelines(s)

f.close()
