import mysql from "mysql2";

// 데이터베이스 연결
const pool = mysql.createPool(
  process.env.JAWSDB_URL ?? {
    host: "localhost",
    user: "root",
    database: "week9_assignment_12181763", // DB파일
    password: "hyungsuk!980208",
    waitForConnections: true,
    connectionLimit: 10,
    queueLimit: 0,
  }
);

// async / await 사용
const promisePool = pool.promise();

// select query
export const selectSql = {
  getBuilding: async () => {
    const [rows] = await promisePool.query(`select * from building`);

    return rows;
  },
  getClass: async () => {
    const [rows] = await promisePool.query(`select * from class`);

    return rows;
  },
  getClub: async () => {
    const [rows] = await promisePool.query(`select * from club`);

    return rows;
  },
  getDepartment: async () => {
    const [rows] = await promisePool.query(`select * from department`);

    return rows;
  },
  getEmployee: async () => {
    const [rows] = await promisePool.query(`select * from employee`);

    return rows;
  },
  getJoin_clubs: async () => {
    const [rows] = await promisePool.query(`select * from join_clubs`);

    return rows;
  },
  getRoom: async () => {
    const [rows] = await promisePool.query(`select * from room`);

    return rows;
  },
  getStudent: async () => {
    const [rows] = await promisePool.query(`select * from student`);

    return rows;
  },
  getTake_classes: async () => {
    const [rows] = await promisePool.query(`select * from take_classes`);

    return rows;
  },
};

// insert query
export const insertSql = {
  // data라는 객체 타입의 파라미터에 입력할 정보를 받아서 query문 생성
  setStudent: async (data) => {
    const sql = `insert into student values (
            "${data.Id}", "${data.Name}", "${data.Email}", "${data.Phone_number}",
            "${data.Major}", "${data.Student_Id}", "${data.Did}")`;

    await promisePool.query(sql);
  },

  setRoom: async (data) => {
    const sql = `insert into room values (
        "${data.Id}", "${data.Name}", "${data.Capacity}", "${data.Bid}", "${data.Did}")`;

    await promisePool.query(sql);
  },

  setBuilding: async (data) => {
    const sql = `insert into building values ("${data.Id}", "${data.Name}")`;

    await promisePool.query(sql);
  },
};

// update query
export const updateSql = {
  updateStudent: async (data) => {
    // where 조건을 만족하는 행에 대해서 수정, 각각의 attribute 별로 분리
    const sql1 = `update student set name = "${data.Name}" where id = "${data.Id}"`;
    await promisePool.query(sql1);

    const sql2 = `update student set email = "${data.Email}" where id = "${data.Id}"`;
    await promisePool.query(sql2);

    const sql3 = `update student set phone_number="${data.Phone_number}" where id = "${data.Id}"`;
    await promisePool.query(sql3);

    const sql4 = `update student set major="${data.Major}" where id = "${data.Id}"`;
    await promisePool.query(sql4);

    const sql5 = `update student set student_id="${data.Student_Id}" where id = "${data.Id}"`;
    await promisePool.query(sql5);

    const sql6 = `update student set  did="${data.Did}" where id = "${data.Id}"`;
    await promisePool.query(sql6);
  },
};
