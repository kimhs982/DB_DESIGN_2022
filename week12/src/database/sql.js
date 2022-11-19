import { Cookie } from "express-session";
import mysql from "mysql2";

// 데이터베이스 연결
const pool = mysql.createPool(
  process.env.JAWSDB_URL ?? {
    host: "localhost",
    user: "root",
    database: "week12_assignment_12181763",
    password: "hyungsuk!980208",
    waitForConnections: true,
    connectionLimit: 10,
    queueLimit: 0,
  }
);

// async / await 사용
const promisePool = pool.promise();

// selec query
export const selectSql = {
  getUsers: async () => {
    const [rows] = await promisePool.query(`select * from student`);

    return rows;
  },
  getTakeClasses: async (data) => {
    const [rows] = await promisePool.query(
      `select Id, Name, Professor, Number_of_participants, Rid, Sid from class, take_classes where (Id = Cid and Sid = ${data})`
    );

    return rows;
  },
  getPossibleClasses: async (data) => {
    const [rows] = await promisePool.query(
      `select Id, Name, Professor, Number_of_participants, Rid from class where Id not in (select Cid from take_classes where Sid = ${data})`
    );

    return rows;
  },
  getStudentId: async (data) => {
    const [rows] = await promisePool.query(
      `select Student_Id from student where Id = ${data}`
    );

    return rows;
  },
  getDepartmentName: async (data) => {
    const [rows] = await promisePool.query(
      `select Name from department where Id = (select Did from student where Id = ${data})`
    );

    return rows;
  },
};

// insert query
export const insertSql = {
  setTakeClasses: async (data) => {
    const sql = `insert into take_classes values (
      "${data.Sid}", "${data.Cid}")`;

    await promisePool.query(sql);
  },
};

// delete query
export const deleteSql = {
  deleteTakeClasses: async (data) => {
    const sql = `delete from take_classes where (Sid = ${data.Sid} and Cid = ${data.Cid})`;

    await promisePool.query(sql);
  },
};
