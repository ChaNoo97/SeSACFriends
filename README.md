# SeSACFriends

## 기록하고싶은 기술

- TimerCancel changes

var Timer: Timer? 

func startTImer() {

timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(timerFunc), userInfo: nil, repeats: true)

}

func stopTimer() {

if timer != nil && timer!.isValid {

timer!.invalidate()

}

}

화면 진입때 : startTimer

화면 나갈때 : stopTimer

- PullToRequest ( scrollView object )

tableView.refreshControl = UIRefreshControl()
tableView.refreshControl?.addTarget(self, action: #selector(refreshTableView), for: .valueChanged)

@objc func  refreshTableView() {

기능구현

}
