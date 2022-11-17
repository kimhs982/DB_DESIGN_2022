import mysql from "mysql2";

const pool = mysql.createPool({
  host: "localhost",
  port: 3306,
  user: "root",
  password: "hyungsuk!980208",
  database: "week4_assignment_12181763",
});

const promisePool = pool.promise();

const sql = {
  insertEmployee: async () => {
    await promisePool.query(`
    insert into employee
    values  (1, '최원익', 'professor', 3),
            (2, '성귀복', 'professor', 6),
            (3, '유상조', 'professor', 3),
            (4, '박인규', 'professor', 3),
            (5, '박재형', 'professor', 3),
            (6, '김민규', 'office worker', 6)
    `);
  },
  getEmployee: async () => {
    const results = await promisePool.query(`
        select * from employee
        `);

    return results;
  },
};

export default sql;
