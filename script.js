const quizData = [
    {
       question: 'which of the following tag is used to mark a begining of paragraph?',
       a: '<TD>',
       b: '<br>',
       c: '<P>',
       d: '<TR>',
       correct: 'c'
    }, {
        question: 'What is the best programming Language in 2019?',
        a: 'Java',
        b: 'C++',
        c: 'Python',
        d: 'Javascript',
       correct: 'a'
    }, {
        question: 'www is based on which model?',
        a: 'Local-server',
        b: 'Client-server',
        c: '3-tier',
        d: 'None of these',
       correct: 'b'
    }, {
        question: 'What does HTML Stands for?',
        a: 'Hyper Text Markup Language',
        b: 'High Text Markup Language',
        c: 'Hyper Tabular Markup Language',
        d: 'None of these',
       correct: 'a'
    }
];

const quiz = document.getElementById("quiz");
const answerEls = document.querySelectorAll(".answer");
const questionE1 = document.getElementById("question");
const a_text = document.getElementById("a_text"); 
const b_text = document.getElementById("b_text"); 
const c_text = document.getElementById("c_text"); 
const d_text = document.getElementById("d_text"); 
const submitBtn = document.getElementById("submit");

let currentQuiz = 0;
let score = 0;

loadQuiz();

function loadQuiz() {
    deselectAnswers();

    const currentQuizData = quizData[currentQuiz];
    
    questionE1.innerText = currentQuizData.question;
    a_text.innerText = currentQuizData.a;
    b_text.innerText = currentQuizData.b;
    c_text.innerText = currentQuizData.c;
    d_text.innerText = currentQuizData.d;
}

function getSelected() {
  
    let answer = undefined;

    answerEls.forEach((answerEl) => {
        if(answerEl.checked) {
            answer = answerEl.id;
        }
    });

    return answer;
}

function deselectAnswers(){
    answerEls.forEach((answerEl) => {
        answerEl.checked = false;
    });
}

submitBtn.addEventListener("click", () => {
    const answer = getSelected();
  

    if(answer) {
        if (answer === quizData[currentQuiz].correct) {
            score++;
        }

        currentQuiz++;
        if(currentQuiz < quizData.length) {
            loadQuiz();
        } else {
            quiz.innerHTML = `<h2>You answered correctly at ${score}/${quizData.length} questions.</h2> 
            
            <button onclick="location.reload()">Try Again</button>`;
        }
       }
});