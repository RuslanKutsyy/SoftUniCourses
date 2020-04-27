function solve() {
   let firstPlayer = document.getElementById('player1Div');
   let secondPlayer = document.getElementById('player2Div');
   let result = document.getElementById('result').children;
   let history = document.getElementById('history');
   let firstPlayerCard = '';
   let secondPlayerCard = '';

   [firstPlayer, secondPlayer].map(player => player.addEventListener('click', function(){
      if (event.target !== undefined) {
         compareValues(player, event);
      }
   }));

   function compareValues(cardPlayer, clickEvent) {
      if (cardPlayer === firstPlayer) {
         firstPlayerCard = clickEvent.target;
         result[0].textContent = clickEvent.target.name;
      } else {
         secondPlayerCard = clickEvent.target;
         result[2].textContent = clickEvent.target.name;
      }

      clickEvent.target.src = "images/whiteCard.jpg";

      if (result[0].textContent !== '' && result[2].textContent !== '') {
         if (Number(result[0].textContent) > Number(result[2].textContent)) {
            colorCards(firstPlayerCard, secondPlayerCard);
         } else {
            colorCards(secondPlayerCard, firstPlayerCard);
         }
         addToHistory(firstPlayerCard, secondPlayerCard);
         defaultSettings();
      }
   }
   function colorCards(card1, card2) {
      card1.style.border = "2px solid green";
      card2.style.border = "2px solid red";
   }

   function addToHistory(card1, card2) {
      history.innerHTML += `[${card1.name} vs ${card2.name}] `;
   }

   function defaultSettings() {
      firstPlayerCard = null;
      secondPlayerCard = null;
      result[0].textContent = null;
      result[2].textContent = null;
   }
}