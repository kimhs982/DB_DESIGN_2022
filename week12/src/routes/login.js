/*
Copyright 2022 khs

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

import cookieParser from "cookie-parser";
import express from "express";
import expressSession from "express-session";
import { selectSql } from "../database/sql";

const router = express.Router();

// 쿠키 및 세션 설정
router.use(cookieParser());
router.use(
  expressSession({
    secret: "dilab",
    resave: true,
    saveUninitialized: true,
  })
);

router.get("/", (req, res) => {
  if (req.cookies.user && req.cookies.user_id) {
    res.render("main", { user: req.cookies.user });
  } else {
    res.render("login");
  }
});

router.get("/logout", (req, res) => {
  if (req.cookies.user && req.cookies.user_id) {
    res.clearCookie("user");
    res.clearCookie("user_id");
    res.redirect("/");
  } else {
    res.redirect("/");
  }
});

router.post("/", async (req, res) => {
  const vars = req.body;
  const users = await selectSql.getUsers();
  let whoAmI = "";
  let studentId = "";
  let checkLogin = false;

  users.map((user) => {
    if (vars.id === user.Student_Id && vars.password === user.Password) {
      checkLogin = true;
      studentId = user.Id;
      whoAmI = user.Name;
    }
  });

  if (checkLogin) {
    res.cookie("user", whoAmI, {
      expires: new Date(Date.now() + 3600000), // ms 단위 (3600000: 1시간 유효)
      httpOnly: true,
    });
    res.cookie("user_id", studentId, {
      expires: new Date(Date.now() + 3600000), // ms 단위 (3600000: 1시간 유효)
      httpOnly: true,
    });
    res.redirect("/");
  } else {
    res.send(
      "<script>alert('로그인에 실패했습니다. 학번과 비밀번호를 확인해주세요.'); location.href='/';</script>"
    );
  }
});

module.exports = router;
