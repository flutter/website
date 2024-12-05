// function setupExpansionPanel() {
//     let coll = document.getElementsByClassName("expansion-panel");
//     let i;
//
//     for (i = 0; i < coll.length; i++) {
//         coll[i].addEventListener("click", function() {
//             console.log('clicked!');
//             this.classList.toggle("expanded");
//             let content = this.nextElementSibling;
//             if (content.style.maxHeight){
//                 content.style.maxHeight = null;
//             } else {
//                 content.style.maxHeight = content.scrollHeight + "px";
//             }
//         });
//     }
// }