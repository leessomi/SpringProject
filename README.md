## Spring-Board-Project
부트스트랩을 이용한 화면 구성과 웹의 기본이 되는 
CRUD게시판을 만들고 필요기능들을 추가해 나가는 방식으로 진행 


#### 🖥️ 프로젝트 소개
전반적인 웹의 기본이 되는 CRUD게시판 프로젝트 
<br>

#### 개발 인원 및 기간
* 1인
* 23.04 - 23.06

### ⚙️ 개발 환경
- `Java 15`
- `JDK 15.0.2`
- **IDE** : STS 3.9.18.RELEASE
- **Framework** : Spring
- **Database** : Oracle DB(11g)
- **ORM** : Mybatis
- **Server** : Apache 9.0.55

## 📌 주요 기능
#### ✔️ 메인 페이지
- 부트스트랩 템플릿을 적용해 k2사이트를 벤치마킹한 메인화면
- 로그인 후 메뉴에 로그인 회원가입이 없어지고 마이페이지 로그아웃으로 바뀜
- 반응형 적용

📷 View
<details>
  <summary>Image</summary>
  https://github.com/leessomi/SpringProject/issues/1#issue-1760346533
</details>

#### ✔️ 게시판
- 글 등록, 조회, 수정, 삭제(CRUD)
- 페이징
- 검색
- 로그인한 회원만 글 작성 가능(안한 상태로 작성 시도 시 로그인 창으로 이동)
- 자기 글만 수정, 삭제 가능

📷 View
<details>
  <summary>Image</summary>
  
</details>

#### ✔️ 댓글
- Ajax 이용한 REST API 방식
- 댓글 등록, 조회, 수정, 삭제(CRUD) - 모달창으로 처리
- 페이징
- 로그인한 회원만 등록 가능
- 자기가 쓴 댓글만 수정, 삭제 가능

📷 View
<details>
  <summary>Image</summary>
  
</details>

#### ✔️ 로그인
- 로그인 후 메인페이지로 이동
- 로그인 유지 
- 아이디 혹은 비밀번호 잘못 입력 시 에러 메세지
- 로그아웃 시 다시 로그인 화면으로 이동(헤더 메뉴는 로그인 전상태로 돌아옴)

<details>
  <summary>Image</summary>
  
</details>

#### ✔️ 회원가입
- 비밀번호 암호화(인코딩) - security
- 주소 API 연동
- ID 중복 체크(Ajax적용)
- 유효성 검사
- 회원가입 후 로그인으로 이동

<details>
  <summary>Image</summary>
  
</details>

#### ✔️ 마이 페이지
- 비밀번호 암호화(인코딩) - security
- 주소 API 연동
- 회원정보 변경

<details>
  <summary>Image</summary>
  
</details>
