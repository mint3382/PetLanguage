# 😼멍냥멍냥
> 프로젝트 기간: 23.10.09 - 23.10.17

## 📖 목차
1. [🍀 소개](#소개)
2. [💻 실행 화면](#실행-화면)
3. [🧨 트러블 슈팅](#트러블-슈팅)
4. [📚 참고 링크](#참고-링크)
5. [👥 팀](#팀)

</br>

<a id="소개"></a>

## 🍀 소개
Chat-GPT를 활용해 마치 고양이나 강아지와 대화하는 것처럼 채팅을 하며 놀 수 있는 심심풀이 앱.

</br>

<a id="실행-화면"></a>

## 💻 실행 화면

| 런치스크린 | 메인 화면 |
|:--------:|:--------:|
|<img src="https://velog.velcdn.com/images/mintsong/post/71b28cc2-e9b9-4f76-8442-c98898214a32/image.gif" alt="launch Screen" width="250">|<img src="https://velog.velcdn.com/images/mintsong/post/b8e1c975-ca3a-453a-870f-4796507e1172/image.gif" alt="main_view" width="250">|

| 이름 입력(keyboard) | 나이 설정(pickerView) |
|:--------:|:--------:|
|<img src="https://velog.velcdn.com/images/mintsong/post/21ff97e4-129b-42a1-993a-3c8fbb11ea9e/image.gif" alt="launch Screen" width="250">|<img src="https://velog.velcdn.com/images/mintsong/post/67c303a8-491b-4d81-87ae-e302cc650163/image.gif" alt="main_view" width="250">|

| 종 선택(segmented control) | 채팅창으로 화면 전환 |
|:--------:|:--------:|
|<img src="https://velog.velcdn.com/images/mintsong/post/3eaa1fd6-6546-426c-bb17-d4ff819c25ac/image.gif" alt="launch Screen" width="250">|<img src="https://velog.velcdn.com/images/mintsong/post/f391b623-d9b2-4799-a2af-46826c067650/image.gif" alt="launch Screen" width="250">|

| 고양이와 채팅 | 강아지와 채팅 |
|:--------:|:--------:|
|<img src="https://velog.velcdn.com/images/mintsong/post/a07d5508-edf8-4c5e-9165-fd6a0d16d55a/image.gif" alt="launch Screen" width="250">|<img src="https://velog.velcdn.com/images/mintsong/post/3acc1c0e-2305-40b4-a667-a1450f22afae/image.gif" alt="main_view" width="250">|


</br>

<a id="트러블-슈팅"></a>

## 🧨 트러블 슈팅
###### 핵심 트러블 슈팅위주로 작성하였습니다.
1️⃣ **HTTP ERROR 429** <br>
-
🔒 **문제점** <br>
처음 서버를 연결한 후 계속 HTTP 상태코드가 429가 뜨면서 response를 받아올 수 없었다.

🔑 **해결방법** <br>
예전에 ChatGPT를 써보고 싶어서 가입한 적이 있었는데 그것 때문에 무료로 제공해주는 기간이 지나서 카드를 입력해서 돈을 내야만 사용할 수 있었다.

<br>


2️⃣ **UILabel 줄바꿈 안됨** <br>
-
🔒 **문제점** <br>
채팅창으로 사용한 UILabel이 줄바꿈이 되지 않아 내용이 전부 나오지 않고 끊기는 문제가 있었다.

🔑 **해결방법** <br>
다이나믹 height를 주기 위해서는 top과 bottom을 잡아주어야 한다. 그 외에도 문제가 해결이 안되니까 tableViewCell을 Cell안의 height에 따라 밖에서 또 height를 바꾸어 주는 코드 등 높이를 바꾸어 주는 조건을 너무 많이 줘서 충돌이 나면서 오히려 되지 않는 것 같아서 top과 bottom을 주는 코드 외에는 height를 건드리는 코드를 전부 삭제하였다.

<br>

3️⃣ **GPT prompt** <br>
-
🔒 **문제점** <br>
단순하게 GPT role 중 system을 설정할 때, "\(name)을 가진 \(age)살의 \(고양이 or 강아지)"라고만 해줬더니 가끔 고양이나 강아지로서가 아니라 인공지능 GPT 로서의 답변을 할 때가 있었다. 예를 들어 "MVVM 알아?" 라고 물어보면 그에 대한 답변이 MVVM에 대한 설명이었다.
![](https://velog.velcdn.com/images/mintsong/post/8f9c6c69-7081-46e6-aee3-009010f4e800/image.png)

🔑 **해결방법** <br>
Pet Type에 따라 prompt를 조금 더 구체적으로, 영어로 작성했다. 
```swift
struct Pet {
    let name: String
    let age: Int
    let species: PetType
    
    func makePrompt() -> String {
        switch species {
        case .cat:
            return  """
                    you are a cat. you're \(age) old.
                    your name is \(name).
                    you hate water.
                    you are rude but cute.
                    and you know that.
                    you have a interest in me.
                    """
        case .dog:
            return  """
                    you are a dog.
                    you're \(age) old.
                    your name is \(name).
                    you love swim and chicken.
                    you are friendly and cute.
                    you love me and I love you.
                    and you know that.
                    """
        }
    }
}

```

<br>

4️⃣ **Label Padding** <br>
-
🔒 **문제점** <br>
![](https://velog.velcdn.com/images/mintsong/post/41ad5b2e-721c-4eb5-be29-4511c95b4b0e/image.png)
Label로 구성하다보니 글자에 딱 맞춰서 붙어있었고 여기에 채팅창 모양처럼 모서리에 곡선을 주고 나니 글자가 짤리기까지 했다.

🔑 **해결방법** <br>
따로 CustomLabel을 만들어주는 것을 통해서 Padding을 지정해주었다.
```swift
final class PaddingLabel: UILabel {
    private var padding = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    
    convenience init(backgroundColor: UIColor) {
        self.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.clipsToBounds = true
        self.layer.cornerRadius = 8
        self.font = .preferredFont(forTextStyle: .caption2)
        self.numberOfLines = 0
        self.preferredMaxLayoutWidth = 300
        self.translatesAutoresizingMaskIntoConstraints = false
    }

    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }

    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.height += padding.top + padding.bottom
        contentSize.width += padding.left + padding.right

        return contentSize
    }
}

```



<br>

<a id="참고-링크"></a>

## 📚 참고 링크
- [🍎Apple Docs: UIPickerView](https://developer.apple.com/documentation/uikit/uipickerview)
- [🍎Apple Docs: UISegmentedControl](https://developer.apple.com/documentation/uikit/uisegmentedcontrol)
- [🍎Apple Docs: UITableView](https://developer.apple.com/documentation/uikit/uitableview)
- <Img src = "https://github.com/mint3382/ios-calculator-app/assets/124643545/56986ab4-dc23-4e29-bdda-f00ec1db809b" width="20"/> [야곰닷넷: autolayout 정복하기](https://yagom.net/courses/autolayout/)
- <Img src = "https://hackmd.io/_uploads/ByTEsGUv3.png" width="20"/> [blog: chatgpt api 사용](https://medium.com/geekculture/creating-ios-version-of-chatgpt-with-official-api-3ee3c7ba9ee0)
- [🤖site: ChatGPT API](https://platform.openai.com/docs/guides/gpt)


</br>

<a id="팀"></a>

## 👥 팀

### 👨‍💻 팀원
| 😈MINT😈 |
| :--------: |
| <img src="https://velog.velcdn.com/images/mintsong/post/4f2fba63-d6c0-48dc-bb4a-49186ac5465b/image.jpg"  width="250" height="200"> |
|[Github Profile](https://github.com/mint3382) |


