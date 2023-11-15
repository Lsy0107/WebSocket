<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<!DOCTYPE html>
	<html>

	<head>
		<meta charset="UTF-8">
		<title>ChatPage</title>
		<style>
			#chatArea {
				border: 3px solid black;
				width: 100%;
				background-color: rgb(105, 105, 167);
				overflow: scroll;
    			max-height: 500px;
				max-width: 500px;
    			overflow-x: hidden;
			}
			#inputMsg>input{
			width: 100%;
			padding:5px; 
			}
			#inputMsg{
			display:flex;
			}

			.Connect,
			.DisConnect {
				color: white;
				text-align: center;
				background-color: gray;
				margin-top: 20px;
				padding: 10px;
				border-radius: 10px;
				margin-left: 30px;
				margin-right: 30px;
			}

			.Message {
				text-align: left;
			}

			.IdTag {
				background-color: none;
				color: black;
				margin-bottom: 2px;
				font-size: 13px;
				margin-left: 5px;
			}

			.RMsgTag {
				background-color: white;
				color: black;
				border-radius: 7px;
				display: inline-block;
				padding: 7px;
				margin-left: 5px;
			}

			.SMsgArea {
				text-align: right;
			}

			.SMsgTag {
				background-color: yellow;
				color: black;
				border-radius: 7px;
				display: inline-block;
				padding: 7px;
				margin-right: 5px;
				margin-top: 5px;
				margin-bottom: 5px;
			}
		</style>
	</head>

	<body>
		<h1>ChatPage.jsp - ${sessionScope.loginId}</h1>
		<div id="chatArea">
			
		</div>
		<hr>
		<div id="inputMsg">
			<input type="text" id="sendMsg">
			<button onclick="sendMsg()" style="width: 80px;">전송</button>
		</div>
		
	</body>
	<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
	<script type="text/javascript">
		var sock = new SockJS('ChatPage');
		sock.onopen = function () {
			console.log('open');
			//sock.send('test'); //서버로 메세지 전송
		};

		sock.onmessage = function (e) {
			//		console.log('message', e.data);
			let msgObj = JSON.parse(e.data);
			console.log("msgtype : " + msgObj.msgtype);
			console.log("msgid : " + msgObj.msgid);
			console.log("msgcomm : " + msgObj.msgcomm)
			//sock.close();
			let mtype = msgObj.msgtype;
			switch (mtype) {
				case "m":
					printMessage(msgObj); //메세지 출력 기능
					break;
				case "c":
					printConnect(msgObj);
					break;
				case "d":
					printDisConnect(msgObj); // 접속 정보 출력 기능
					break;
			}
		};

		sock.onclose = function () {
			console.log('close');
		};
	</script>
	<script type="text/javascript">
		let MsgDivArea = document.querySelector('#chatArea');
		function sendMsg() {
			let msgInput = document.querySelector("#sendMsg");
			sock.send(msgInput.value);

			let SMsgDivArea = document.createElement('div'); //div area
			SMsgDivArea.classList.add('SMsgArea');

			let SMsgTag = document.createElement('div'); //메세지 태그
			SMsgTag.classList.add('SMsgTag');
			SMsgTag.innerText = msgInput.value;
			SMsgDivArea.appendChild(SMsgTag);

			MsgDivArea.appendChild(SMsgDivArea);

			msgInput.value = "";
		}
	</script>

	<script type="text/javascript">
		let printConnectDiv = document.querySelector('#chatArea');
		function printConnect(msgObj) {

			let ConnectDiv = document.createElement('div');
			ConnectDiv.classList.add('Connect');
			ConnectDiv.innerText = msgObj.msgid + "(이)가 접속했습니다";
			printConnectDiv.appendChild(ConnectDiv);
		}

	</script>

	<script type="text/javascript">
		let printDisConnectDiv = document.querySelector('#chatArea');
		function printDisConnect(msgObj) {

			let ConnectDiv = document.createElement('div');
			ConnectDiv.classList.add('DisConnect');
			ConnectDiv.innerText = msgObj.msgid + "(이)가 접속해제했습니다";
			printDisConnectDiv.appendChild(ConnectDiv);
		}

	</script>

	<script type="text/javascript">
		let printMessageDiv = document.querySelector('#chatArea');
		function printMessage(msgObj) {

			let MessageDiv = document.createElement('div');
			MessageDiv.classList.add('Message');

			let IdDiv = document.createElement('div');
			IdDiv.classList.add('IdTag'); //사용자 id태그 출력
			IdDiv.innerText = msgObj.msgid;
			MessageDiv.appendChild(IdDiv);

			let MsgDiv = document.createElement('div');
			MsgDiv.classList.add('RMsgTag'); //받은 메세지 태그 출력 
			MsgDiv.innerText = msgObj.msgcomm;
			MessageDiv.appendChild(MsgDiv);

			printMessageDiv.appendChild(MessageDiv);
		}
	</script>

	</html>