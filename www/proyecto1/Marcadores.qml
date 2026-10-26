import QtQuick

Item{
    Component.onCompleted: {
        let j={}
        j.items=[]
        let item
        let marcs
        let marc

        //app.positionMin=33*1000
        //Item 1
        item={}
        item.url="file:///storage/emulated/0/Download/Telegram/cora2.mp4"
        item.tit="CORA N°2"
        item.des="Resumen del video"
        marcs=[]

        marc={}
        marc.titulo="ME VUELVO A VER"
        marc.des="Mirarse desde afuera sin piedad."
        marc.ms=getHmsToMs(0, 1, 51)
        marc.msf=getHmsToMs(0, 2, 22)
        marcs.push(marc)

        marc={}
        marc.titulo="UN BOLUDO GEMINIANO"
        marc.des="Diciendo por vez un millón que soy Geminiano."
        marc.ms=getHmsToMs(0, 2, 22)
        marc.msf=getHmsToMs(0, 3, 19)
        marcs.push(marc)

        marc={}
        marc.titulo="OJO! ASCENDENTE ACUARIO!"
        marc.des="El que no entiende qué es esto escucha esto y está en pelotas."
        marc.ms=getHmsToMs(0, 3, 20)
        marc.msf=getHmsToMs(0, 4, 1)
        marcs.push(marc)

        marc={}
        marc.titulo="MI FUKING PUNTO DE VISTA"
        marc.des="Lo dicho! Lo compartí conmigo mismo!"
        marc.ms=getHmsToMs(0, 4, 1)
        marc.msf=getHmsToMs(0, 4, 29)
        marcs.push(marc)

        marc={}
        marc.titulo="ELEMENTO AIRE"
        marc.des="La sanata pseudo científica. jaja"
        marc.ms=getHmsToMs(0, 4, 29)
        marc.msf=getHmsToMs(0, 6, 11)
        marcs.push(marc)

        marc={}
        marc.titulo="ME COMPARTO A MI MISMO"
        marc.des="Luego "
        marc.ms=getHmsToMs(0, 6, 11)
        marc.msf=getHmsToMs(0, 6, 48)
        marcs.push(marc)

        marc={}
        marc.titulo="Soy más PLATÓNICO QUE LCDTM!!!"
        marc.des="La contradicción"
        marc.ms=getHmsToMs(0, 20, 6)
        marc.msf=getHmsToMs(0, 21, 43)
        marcs.push(marc)

        marc={}
        marc.titulo="GELATINA TENES EN EL BOCHO!!!"
        marc.des="COLGATE DE LA MONADOLOGÏA CHABÓN!!! o caes a un abismo de incredulidad y desprestigio mal."
        marc.ms=getHmsToMs(0, 22, 7)
        marc.msf=getHmsToMs(0, 24, 30)
        marcs.push(marc)

        marc={}
        marc.titulo="MÁS CONTRADICCIÓNES!!!!"
        marc.des="Me pongo serio y explico que todos estos conceptos tienen una fuente hiper racional de donde derivan las verdades \"ACTUALES\" más cercanas a la \"VERDAD ABSOLUTA\""
        marc.ms=getHmsToMs(0, 24, 30)
        marc.msf=getHmsToMs(0, 26, 7)
        marcs.push(marc)

        item.marcs=marcs
        j.items.push(item)

        app.json=j

        app.loadDataAudios()
        app.loadData(0)

    }
}
