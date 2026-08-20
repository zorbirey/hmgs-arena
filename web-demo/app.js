const screens = [...document.querySelectorAll('.screen')];
const show = id => { screens.forEach(s => s.classList.remove('active')); document.getElementById(id).classList.add('active'); };
const toast = message => { const el=document.getElementById('toast'); el.textContent=message; el.classList.remove('hidden'); setTimeout(()=>el.classList.add('hidden'),2400); };

const demoQuestions = [
 {id:'q1',subject:'Anayasa Hukuku',topic:'Temel İlkeler',q:'Türkiye Cumhuriyeti Anayasası’na göre egemenlik kayıtsız şartsız kime aittir?',o:['TBMM’ye','Millete','Cumhurbaşkanına','Yargı organlarına','Devlete'],a:1,e:'Anayasa m.6: Egemenlik, kayıtsız şartsız Milletindir.'},
 {id:'q2',subject:'Medeni Hukuk',topic:'Kişiler Hukuku',q:'Türk Medeni Kanunu’na göre erginlik kural olarak kaç yaşın doldurulmasıyla başlar?',o:['15','16','17','18','21'],a:3,e:'TMK m.11 uyarınca erginlik on sekiz yaşın doldurulmasıyla başlar.'},
 {id:'q3',subject:'Borçlar Hukuku',topic:'Sözleşme',q:'Bir sözleşmenin kurulması için tarafların irade açıklamalarının kural olarak nasıl olması gerekir?',o:['Yazılı olması','Noterde yapılması','Karşılıklı ve birbirine uygun olması','Tanık huzurunda yapılması','Tescil edilmesi'],a:2,e:'Sözleşme, tarafların karşılıklı ve birbirine uygun irade açıklamalarıyla kurulur.'},
 {id:'q4',subject:'Ceza Hukuku',topic:'Kanunilik',q:'Suçta ve cezada kanunilik ilkesi aşağıdakilerden hangisini esas alır?',o:['Kıyasın serbestliğini','İdarenin ceza koyabilmesini','Kanunsuz suç ve ceza olmamasını','Hakimin sınırsız takdirini','Örf ve adetle suç yaratılmasını'],a:2,e:'Kanunda açıkça suç sayılmayan bir fiil için kimseye ceza verilemez.'},
 {id:'q5',subject:'Ceza Muhakemesi',topic:'Şüpheli ve Sanık',q:'Ceza muhakemesinde “sanık” sıfatı kural olarak hangi aşamadan sonra kullanılır?',o:['İhbarla','Soruşturmanın başlamasıyla','İddianamenin kabulüyle','Gözaltıyla','Yakalamayla'],a:2,e:'Kovuşturmanın başlamasıyla kişi sanık sıfatını alır; iddianamenin kabulü kovuşturmayı başlatır.'},
 {id:'q6',subject:'Medeni Usul',topic:'Dava Şartları',q:'Aşağıdakilerden hangisi dava şartlarının genel niteliğini en doğru açıklar?',o:['Sadece davalı ileri sürerse incelenir','Mahkemece kendiliğinden incelenebilir','Yalnız temyizde incelenir','Taraflar anlaşırsa aranmaz','Sadece ceza davalarında uygulanır'],a:1,e:'Dava şartları mahkemece davanın her aşamasında kendiliğinden araştırılır.'},
 {id:'q7',subject:'İdare Hukuku',topic:'İdari İşlem',q:'İdari işlemin temel özelliklerinden biri aşağıdakilerden hangisidir?',o:['Mutlaka iki taraflı olması','Özel hukuk sözleşmesi olması','Tek yanlı olarak hukuki sonuç doğurabilmesi','Sadece mahkemece yapılması','Her zaman sözlü olması'],a:2,e:'İdari işlemler idarenin tek yanlı irade açıklamasıyla hukuki sonuç doğurabilir.'},
 {id:'q8',subject:'Ticaret Hukuku',topic:'Tacir',q:'Ticari işletmeyi kısmen dahi olsa kendi adına işleten kişiye ne ad verilir?',o:['Esnaf','Tacir','Komisyoncu','Tüketici','Vekil'],a:1,e:'TTK sisteminde ticari işletmeyi kendi adına işleten kişi tacirdir.'},
 {id:'q9',subject:'İş Hukuku',topic:'İş Sözleşmesi',q:'İş sözleşmesinin ayırt edici unsurlarından biri aşağıdakilerden hangisidir?',o:['Bağımlılık','Mirasçılık','Ortaklık payı','Kamu gücü','Vesayet'],a:0,e:'İş sözleşmesinde iş görme, ücret ve bağımlılık unsurları öne çıkar.'},
 {id:'q10',subject:'İcra ve İflas',topic:'Takip Hukuku',q:'İcra hukukunun temel amacı aşağıdakilerden hangisidir?',o:['Yeni suç tipleri yaratmak','Özel hukuk alacaklarının devlet gücüyle yerine getirilmesini sağlamak','Kanunları iptal etmek','Vergi oranlarını belirlemek','İdari işlem tesis etmek'],a:1,e:'İcra hukuku, alacakların devletin cebri icra organları aracılığıyla yerine getirilmesini düzenler.'}
];

const state = JSON.parse(localStorage.getItem('hmgsArenaDemo') || '{}');
state.xp ??= 0; state.completed ??= 0; state.lastTopic ??= 'Anayasa Hukuku · Temel İlkeler';
function save(){ localStorage.setItem('hmgsArenaDemo', JSON.stringify(state)); renderDashboard(); }
function renderDashboard(){ document.getElementById('xp').textContent=state.xp.toLocaleString('tr-TR'); document.getElementById('continueText').textContent=state.lastTopic; }

let qi=0, selected=null, correct=0, timer=null, remaining=78;
function startQuiz(){ qi=0; selected=null; correct=0; show('quiz'); renderQuestion(); }
function stopTimer(){ if(timer){clearInterval(timer);timer=null;} }
function renderQuestion(){
 stopTimer(); selected=null; remaining=78;
 const q=demoQuestions[qi];
 document.getElementById('qProgress').textContent=`${qi+1} / ${demoQuestions.length}`;
 document.getElementById('subject').textContent=`${q.subject} · ${q.topic}`;
 document.getElementById('questionText').textContent=q.q;
 document.getElementById('feedback').classList.add('hidden');
 document.getElementById('nextQuestion').classList.add('hidden');
 const options=document.getElementById('options'); options.innerHTML='';
 q.o.forEach((text,i)=>{ const b=document.createElement('button'); b.className='option'; b.innerHTML=`<span class="letter">${String.fromCharCode(65+i)}</span><span>${text}</span>`; b.onclick=()=>answer(i,b); options.appendChild(b); });
 updateTimer(); timer=setInterval(()=>{remaining--;updateTimer();if(remaining<=0){stopTimer(); if(selected===null) timeoutAnswer();}},1000);
}
function updateTimer(){ const el=document.getElementById('questionTimer'); el.textContent=`${String(Math.floor(remaining/60)).padStart(2,'0')}:${String(remaining%60).padStart(2,'0')}`; el.classList.toggle('danger',remaining<=10&&selected===null); }
function answer(index,button){ if(selected!==null)return; selected=index; stopTimer(); const q=demoQuestions[qi]; const buttons=[...document.querySelectorAll('.option')]; buttons.forEach((b,i)=>{b.disabled=true;if(i===q.a)b.classList.add('correct')}); if(index===q.a){correct++;button.classList.add('correct')}else button.classList.add('wrong'); const fb=document.getElementById('feedback'); fb.textContent=q.e; fb.classList.remove('hidden'); document.getElementById('nextQuestion').classList.remove('hidden'); state.lastTopic=`${q.subject} · ${q.topic}`; save(); }
function timeoutAnswer(){ const q=demoQuestions[qi]; [...document.querySelectorAll('.option')].forEach((b,i)=>{b.disabled=true;if(i===q.a)b.classList.add('correct')}); const fb=document.getElementById('feedback'); fb.textContent=`Süre doldu. ${q.e}`; fb.classList.remove('hidden'); document.getElementById('nextQuestion').classList.remove('hidden'); }
function finishQuiz(){ stopTimer(); const earned=correct*100; state.xp+=earned; state.completed+=demoQuestions.length; save(); document.getElementById('score').textContent=`${correct} / ${demoQuestions.length}`; document.getElementById('correctCount').textContent=correct; document.getElementById('wrongCount').textContent=demoQuestions.length-correct; document.getElementById('earnedXp').textContent=`+${earned}`; document.getElementById('resultMessage').textContent=correct>=8?'Arena seni tanımaya başladı. Güçlü başlangıç.':correct>=5?'İyi başlangıç. Zayıf konuların şekilleniyor.':'İlk ölçüm tamamlandı. Çalışma rotanı birlikte güçlendireceğiz.'; show('result'); }

document.getElementById('startQuiz').onclick=startQuiz;
document.getElementById('continueBtn').onclick=startQuiz;
document.getElementById('quitQuiz').onclick=()=>{stopTimer();show('dashboard')};
document.getElementById('nextQuestion').onclick=()=>{ if(qi<demoQuestions.length-1){qi++;renderQuestion()}else finishQuiz(); };
document.getElementById('backHome').onclick=()=>show('dashboard');
document.getElementById('demoExam').onclick=()=>toast('Tam deneme altyapısı hazır. 120 doğrulanmış soru tamamlanınca aktif olacak.');

renderDashboard();
setTimeout(()=>{show('splash2');setTimeout(()=>show('dashboard'),3000)},3000);
