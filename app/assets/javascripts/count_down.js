// $(function() {
  //   countDown();
  // });
let countDownTimer = function() {
  setInterval(function() {
    let startDateTime = new Date();
    let endDateTime = new Date("June 22, 2018 21:00:00");
    let left = endDateTime - startDateTime;
    let a_day = 24 * 60 * 60 * 1000;

    let h = Math.floor((left % a_day) / (60 * 60 * 1000))
    let m = Math.floor((left % a_day) / (60 * 1000)) % 60
    let s = Math.floor((left % a_day) / 1000) % 60 % 60

    text = h + '時間' + m + '分' + s + '秒'
    document.getElementById('countdown-timer').innerHTML = text;
  }, 1000)
}

// countDownTimer();
