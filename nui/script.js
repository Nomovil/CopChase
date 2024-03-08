window.addEventListener("message", (event) => {
    const data = event.data;
    // console.log(JSON.stringify(data))
    var visible = data.slowed || data.speedboost || data.invCtrl || data.wanted || data.ramp || data.fixcar || data.slowcops || data.slowthief
    var rgba = 'rgba(0,0,0,1)'
    if (!visible) {
        rgba = 'rgba(0,0,0,0)'
    }

    var elements = document.getElementsByClassName('messages');
    for (var i = 0; i < elements.length; i++) {
        elements[i].style.backgroundColor  = rgba;
    }
    

    modMessage("Slowed","You are Slowed", visible ? data.slowed: false,data.slowed_alpha)
    modMessage("Speedbooster","You got a Speedboost", visible ? data.speedboost : false,data.speedboost_alpha, "white", false)
    modMessage("InvContols","You Controls are Inverted", visible ? data.invCtrl : false,data.invCtrl_alpha)
    modMessage("PlayerWanted","You are Wanted", visible ? data.wanted : false,data.wanted_alpha)
    modMessage("SpawnedRamp","RAAAAAMP it!!!", visible ? data.ramp : false,data.ramp_alpha)
    modMessage("FixCar","You Car got fixed", visible ? data.fixcar : false,data.fixcar_alpha, "white", false)
    modMessage("SlowCops","Cops are Slowed", visible ? data.slowcops : false,data.slowcops_alpha,"lightblue")
    modMessage("SlowThief","Thiefs are Slowed", visible ? data.slowthief : false,data.slowthief_alpha,"orange")
});

function mapValue(value, minOriginal, maxOriginal, minNeu, maxNeu) {
    return ((value - minOriginal) / (maxOriginal - minOriginal)) * (maxNeu - minNeu) + minNeu;
}

function modMessage(elementName,text,visible,alpha,color = "white",percent = false) {
    var new_alpha = mapValue(alpha,0,1,0.5,1)
    if (alpha <= 0.25) {
        document.getElementById(elementName).style.color = "red"
    } else {
        document.getElementById(elementName).style.color = color
    }
    text =percent ? (alpha+0.1)*10 + "s "+ text: text
    document.getElementById(elementName).textContent = visible ? text : ""
    document.getElementById(elementName).style.opacity = alpha ? new_alpha : 0.5
}