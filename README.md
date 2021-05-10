# Flutter Movie Project

## 사용 라이브러리

- [Provider](https://pub.dev/packages/provider)

- [Http](https://pub.dev/packages/http)

- [Google_Fonts](https://pub.dev/packages/google_fonts)

- [Flutter_Rating_Bar](https://pub.dev/packages/flutter_rating_bar)

- [flutter_config](https://pub.dev/packages/flutter_config)




## Todo

- [x] 퍼블리싱
 
- [x] 앱 구동시 리스트 페이지 출력
 
- [x] 각 아이템 클릭 시 상세페이지 이동 후 정보출력
 
- [x] 현재 상영중 영역 가로 스크롤 Pagination 구현
 
- [x] 개봉 예정, 인기, 높은 평점 영역 최대 3개까지 출력

- [ ] 상세정보 리뷰 

- [x] Provider 리팩토링

- [ ] 에러 처리

- [ ] .env API_KEY 등록(gitIgnore는 결과 나오고 나중에 하겠습니다.)

## 프로젝트 소감
> 항상 firebase를 사용하다가 http 페이지네이션을 구현하게 되어 좋은 경험이 되었습니다.

> 리스트 조회를 하면 백엔드에서 장르 이름이 아닌 번호로만 데이터가 나와 백엔드 쪽의 수정이 필요하다 생각하여 불필요한 데이터 조회는 장르 번호로만 띄웠습니다.
> getReviewById 라는 api도 별도로 없어 번호로만 나열해놨습니다.

> 리뷰데이터가 비어있어서 데이터모델링을 할 수 없어 제대로 구현을 못한거 같아 아쉽습니다.
