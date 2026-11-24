import QtQuick

Item{
    id: r
    property var j: ({items:[]})
    Component.onCompleted: {
        //Item 1
        addItem("file:///storage/emulated/0/Download/Telegram/cora2.mp4", "CORA N°2", "Resumen del video")

        addMarc(
                    "ME VUELVO A VER",
                    "Mirarse desde afuera sin piedad.",
                    [0, 1, 51], [0, 2, 22]
                    )

        addMarc(
                    "UN BOLUDO GEMINIANO",
                    "Diciendo por vez un millón que soy Geminiano.",
                    [0, 2, 22],
                    [0, 3, 19]
                    )

        addMarc(
                    "OJO! ASCENDENTE ACUARIO!",
                    "El que no entiende qué es esto escucha esto y está en pelotas.",
                    [0, 3, 20],
                    [0, 4, 1]
                    )
        addMarc(
                    "MI FUKING PUNTO DE VISTA",
                    "Lo dicho! Lo compartí conmigo mismo!",
                    [0, 4, 1],
                    [0, 4, 29]
                    )

        addMarc(
                    "ELEMENTO AIRE",
                    "La sanata pseudo científica. jaja",
                    [0, 4, 29],
                    [0, 6, 11]
                    )
        addMarc(
                    "ME COMPARTO A MI MISMO",
                    "Luego...",
                    [0, 6, 11],
                    [0, 6, 48]
                    )

        addMarc(
                    "Soy más PLATÓNICO QUE LCDTM!!!",
                    "La contradicción",
                    [0, 20, 6],
                    [0, 21, 43]
                    )

        addMarc(
                    "GELATINA TENES EN EL BOCHO!!!",
                    "COLGATE DE LA MONADOLOGÏA CHABÓN!!! o caes a un abismo de incredulidad y desprestigio mal.",
                    [0, 22, 7],
                    [0, 24, 30]
                    )
        addMarc(
                    "MÁS CONTRADICCIÓNES!!!!",
                    "Me pongo serio y explico que todos estos conceptos tienen una fuente hiper racional de donde derivan las verdades \"ACTUALES\" más cercanas a la \"VERDAD ABSOLUTA\"",
                    [0, 24, 30],
                    [0, 26, 7]
                    )

        app.json=r.j

        app.loadDataAudios()
        app.loadData(0)

    }
    function addItem(url, tit, des){
        let item={}
        item.url=url
        item.tit=tit
        item.des=des
        r.j.items.push(item)
    }
    function addMarc(tit, des, aHMSInicio, aHMSFin){
        let index=r.j.items.length-1
        let marc={}
        marc.titulo=tit
        marc.des=des
        marc.ms=getHmsToMs(aHMSInicio[0], aHMSInicio[1], aHMSInicio[2])
        marc.msf=getHmsToMs(aHMSFin[0], aHMSFin[1], aHMSFin[2])
        if(!r.j.items[index].marcs){
            r.j.items[index].marcs=[]
        }
        r.j.items[index].marcs.push(marc)
    }
}
