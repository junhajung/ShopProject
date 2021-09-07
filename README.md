# 쇼핑몰 프로젝트

## 간단한 프로젝트 설명
RDBMS인 Oracle과 Spring FrameWork를 활용하여 구현한 웹 사이트이며  
기본적인 쇼핑몰에 필요한 장바구니, 상품리스트 출력 및 상세보기, 주문, 로그인 및 회원가입,  
마이페이지, 상품문의, 검색, 관리자 화면 (상품 추가, 삭제, 공지사항 작성 등..)이 구현되어 있습니다.  

## 개발 기간 및 인력
약 2주 소요, 1인 프로젝트  

### 사용언어
Java, Jsp, Html, css, Jpa 

## Use Case
![image](https://user-images.githubusercontent.com/48474613/132299437-9148519e-bcfa-4891-bfd9-e74f46a00c00.png)

## ERD
![image](https://user-images.githubusercontent.com/48474613/132299458-9a35adf6-88a6-4ba6-a21d-2ea4aeed2ea3.png)

## Intallation

개발환경은 Eclipse이며 실행환경은 localhost:9091 로 실행이 가능합니다.

* Apache Tomcat Version - 9.0
* Java Version - 11.0.10
* Eclipse Version - 4.18.0
* Spring Version - 2.4.4

* * *

### 마치면서 아쉬운 부분
처음 데이터베이스를 설계할 때 Product table의 pk를 String인 name값으로 설정을 해버려서 제약사항이 많았습니다.  
혹시 제 코드를 참조하신다면 pk를 AutoIncrease 되는 index를 활용하여 재구현하시길 바랍니다.
