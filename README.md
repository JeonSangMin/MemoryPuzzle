# MemoryPuzzle

![스크린샷 2020-05-22 오후 6 21 49](https://user-images.githubusercontent.com/15086391/82652769-241b1b00-9c59-11ea-872c-a1038d269dd9.png)



## 개요

- 개발 기간 : 2020.02.04 ~ 2020.02.07
- 참여 인원 : 2명
- 개발 목표 : UICollectionView에 대한 이해, AVFoundation 사용

- 사용 기술
  - Language: Swift5
  - Framework: UIKit, AVFoundation
  - Library: SnapKit, SwiftyGif
- 담당 구현 파트
  - 게임 진행시 필요한 기능 구현 (카드 쌍 비교 판정, 최고 기록 저장 등)
  - 구현에 필요한 Asset 수집 (배경화면 이미지, 사운드 녹음 등)



## 시연 영상

|                             시작                             |                            플레잉                            |                           일시정지                           |                             기록                             |
| :----------------------------------------------------------: | :----------------------------------------------------------: | :----------------------------------------------------------: | :----------------------------------------------------------: |
| ![시작](https://user-images.githubusercontent.com/15086391/82649789-b4a32c80-9c54-11ea-94ab-366d0944cf3f.gif) | ![인게임](https://user-images.githubusercontent.com/15086391/82649832-bff65800-9c54-11ea-9e47-7e17bf639242.gif) | ![일시정지](https://user-images.githubusercontent.com/15086391/82649840-c4227580-9c54-11ea-8ec0-b41065dab2a3.gif) | ![기록](https://user-images.githubusercontent.com/15086391/82649847-c5ec3900-9c54-11ea-822b-232ddd7d3890.gif) |

- 시작 : gif를 사용하여 LaunchScreen을 구현하였습니다



- Ingame : 

  - UICollectionView의 isSelected 속성을 사용하여 구현하였습니다
  - 메인화면에서 스테이지를 선택하면 2초간 정답을 보여준 후 게임이 시작됩니다
  - 게임이 시작됨과 동시에 Timer가 돌기 시작합니다
  - 모든 쌍을 맞춤과 동시에 게임이 종료됩니다
  - 카드는 뒷면을 향해 있을 때만 뒤집을 수 있습니다
  - 카드가 앞면을 향해 있거나, 앞면에서 뒤로 돌아가는 도중에는 카드를 touch 할 수 없습니다
  - NIGHTMARE 스테이지와, HELL 스테이지만 시연을 위해 한쌍만 맞춰도 클리어 되도록 설정해두었습니다

  

- 일시 정지 :

  - 상단 오른쪽의 'PAUSE' 버튼을 눌러서 Timer를 일시정지 할 수 있습니다
  - 게임이 정지되어 있는 상태에서는 touch 할 수 없습니다

  

- 기록 : 

  - 게임이 끝나는 시점에 최단시간 클리어 기록이 저장됩니다
  - 스테이지별 최고 기록을 확인 할 수 있습니다.
