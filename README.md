# SeSACFriends

## 어플소개
새싹 동료들끼리 취미를 공유하고 같이 만나서 할수있게 매칭해주는 서비스 입니다.

### 개발기간
22.01.17~22.02.23

## 기술스택
`MVVM` `SnapKit` `RESTAPI` `Alamofire` `Socket.IO` `FirebaseAuth` `FirebaseCloudMessage` `CLLocation` `MapKit`
### 상세설명
- MVVM 패턴을 적용했습니다.
- Code 의 재사용성에 대해 생각하고 적극적으로 모듈화를 해주었습니다.
- CodeBaseUI로 Snapkit을 사용하여 만들었습니다.
- Reuseable에 관련된 identifier를 protocol을 활용하여 자동으로 처리해주었습니다.
- Alamofire을 활용하여 RestAPI를 구현하고, CRUD를 모두 구현했습니다.
- FirebaseAuth를 활용해서 회원가입시 핸드폰 인증 로직을 구현했습니다.
- 로그인시 토큰이 생성되며 토큰이 만료될시 토큰을 재생성하고 이후 로직을 정상적으로 실행되게 구현했습니다.
- CLLocation을 활용해서 위치권한관련 로직을 구현하고, 사용자의 위치에 따라서 Map에 현재위치를 표시할수 있습니다.
- CustomAnnotation으로 사용자의 매칭을 기다리는 사용자의 위치를 표시할수 있습니다.
- 실시간 정보를 확인하기 위해서 당겨서 새로고침 기능이 있습니다.(pull To Refresh)
- 모든화면에 키보드 대응이 되어 있습니다.
- 채팅방을 구현하고, Socket.IO를 이용하여 실시간 채팅이 가능합니다.
- FirebaseCloudMessage를 활용하여 푸시알림을 받을수 있습니다.

## 트러블슈팅
- 로그인 과정에서 validation을 여러개 사용해줘야 했습니다. 모두 다른 위치에서 코드로 처리해주었는데 모듈화를 통해서 가독성을 높여주고, 확장성을 확보해볼수 있었습니다.
- 채팅화면의 textView의 edgeInset이 존재하여 원하지 않는 UI가 만들어 졌는데, edgeInset 값을 바꿔줘서 해결했습니다.
- viewModel의 일부 property를 공유해야 하는 상황이 있어서 해당 viewModel을 싱글톤으로 처리해주었습니다.
- MVVM패턴임에도 불구하고 API 상태코드에 따라서 분기처리를 해주는 부분때문에 viewController에 코드가 길어졌었습니다. viewModel에서 분기처리를 진행해주고, 토스트 메세지를 띄워야 하는 경우에는 escaping closure 을 사용하여 string값만 가져오면 viewController에서 띄워주기만 할수 있도록 로직을 개선했습니다.
- API 상태 코드처리를 해줄때, integer값으로 터프하게 처리해주다 보니 가독성이 떨어지고, 오타가 발생했습니다. enum을 만들어서 가독성 문제를 해결하고, 혹시 발생할수 있는 오타의 오류에 대응할수 있도록 처리했습니다.
- NotificationObserver 을 사용할때에 해당 observer의 메서드가 두번씩 실행되는 이슈가 존재했습니다. 화면전환이 일어날때 사용되는 NotificationObserver을 remove 해주어서 해당 이슈를 해결했습니다.

## 구현화면
|전화번호 입력|전화번호 인증|회원가입 플로우|
|---|---|---|
|<img src="https://user-images.githubusercontent.com/89408824/156182174-1bb8dae7-3223-45f7-905f-bb4cea34fe1f.gif" width="210" height="350"/>|<img src="https://user-images.githubusercontent.com/89408824/156182396-fab813c9-799e-4153-a42e-e38853c5bf23.gif" width="210" height="350"/>|<img src="https://user-images.githubusercontent.com/89408824/156182469-1315d612-5c4b-42b9-a1cf-edebb287f10e.gif" width="210" height="350"/>|

|customAnnotation|주변 사람들세부정보|
|---|---|
|<img src="https://user-images.githubusercontent.com/89408824/156182444-8b26831c-11ab-4405-8cba-cce953350def.png" width="210" height="350"/>|<img src="https://user-images.githubusercontent.com/89408824/156182426-d9897352-6059-4b33-a40b-c60f375ff763.gif" width="210" height="350"/>|

|채팅화면|
|---|
|<img src="https://user-images.githubusercontent.com/89408824/156182454-4db8a878-2f26-44ce-aded-d26da0f54f55.gif" width="210" height="350"/>|
