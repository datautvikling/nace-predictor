module NaceCodes exposing (codeAndDescription)

import Dict exposing (Dict)
import Maybe exposing (withDefault)


codeAndDescription : String -> String
codeAndDescription code =
    let
        description =
            codeToDescription
                |> Dict.get code
                |> withDefault "Ukjent kode"
    in
    code ++ ": " ++ description


codeToDescription : Dict String String
codeToDescription =
    Dict.fromList
        [ ( "00.000"
          , "Uoppgitt"
          )
        , ( "01.110"
          , "Dyrking av korn (unntatt ris), belgvekster og oljeholdige vekster"
          )
        , ( "01.120"
          , "Dyrking av ris"
          )
        , ( "01.130"
          , "Dyrking av grønnsaker, meloner, rot- og knollvekster"
          )
        , ( "01.140"
          , "Dyrking av sukkerrør"
          )
        , ( "01.150"
          , "Dyrking av tobakk"
          )
        , ( "01.160"
          , "Dyrking av fibervekster"
          )
        , ( "01.190"
          , "Dyrking av ettårige vekster ellers"
          )
        , ( "01.210"
          , "Dyrking av druer"
          )
        , ( "01.220"
          , "Dyrking av tropiske og subtropiske frukter"
          )
        , ( "01.230"
          , "Dyrking av sitrusfrukter"
          )
        , ( "01.240"
          , "Dyrking av kjernefrukter og steinfrukter"
          )
        , ( "01.260"
          , "Dyrking av oljeholdige frukter"
          )
        , ( "01.270"
          , "Dyrking av vekster for produksjon av drikkevarer"
          )
        , ( "01.280"
          , "Dyrking av krydder og aromatiske, medisinske og farmasøytiske vekster"
          )
        , ( "01.290"
          , "Dyrking av flerårige vekster ellers"
          )
        , ( "01.300"
          , "Planteformering"
          )
        , ( "01.410"
          , "Melkeproduksjon på storfe"
          )
        , ( "01.420"
          , "Oppdrett av annet storfe"
          )
        , ( "01.430"
          , "Oppdrett av hester og andre dyr av hestefamilien"
          )
        , ( "01.440"
          , "Oppdrett av kameler og andre kameldyr"
          )
        , ( "01.451"
          , "Sauehold"
          )
        , ( "01.452"
          , "Geitehold"
          )
        , ( "01.460"
          , "Svinehold"
          )
        , ( "01.471"
          , "Hold av verpehøner for konsumeggproduksjon"
          )
        , ( "01.479"
          , "Annet fjørfehold"
          )
        , ( "01.490"
          , "Husdyrhold ellers"
          )
        , ( "01.500"
          , "Kombinert husdyrhold og planteproduksjon"
          )
        , ( "01.610"
          , "Tjenester tilknyttet planteproduksjon"
          )
        , ( "01.630"
          , "Etterbehandling av vekster etter innhøsting"
          )
        , ( "01.640"
          , "Behandling av såfrø"
          )
        , ( "01.700"
          , "Jakt, viltstell og tjenester tilknyttet jakt og viltstell"
          )
        , ( "02.100"
          , "Skogskjøtsel og andre skogbruksaktiviteter"
          )
        , ( "02.200"
          , "Avvirkning"
          )
        , ( "02.300"
          , "Innsamling av viltvoksende produkter av annet enn tre"
          )
        , ( "02.400"
          , "Tjenester tilknyttet skogbruk"
          )
        , ( "03.111"
          , "Hav- og kystfiske"
          )
        , ( "03.112"
          , "Hvalfangst"
          )
        , ( "03.120"
          , "Ferskvannsfiske"
          )
        , ( "03.211"
          , "Produksjon av matfisk og skalldyr i hav- og kystbasert fiskeoppdrett"
          )
        , ( "03.212"
          , "Produksjon av yngel og settefisk i hav- og kystbasert fiskeoppdrett"
          )
        , ( "03.213"
          , "Tjenester tilknyttet hav- og kystbasert fiskeoppdrett"
          )
        , ( "03.221"
          , "Produksjon av matfisk og skalldyr i ferskvannsbasert fiskeoppdrett"
          )
        , ( "03.222"
          , "Produksjon av yngel og settefisk i ferskvannsbasert fiskeoppdrett"
          )
        , ( "03.223"
          , "Tjenester tilknyttet ferskvannsbasert fiskeoppdrett"
          )
        , ( "05.100"
          , "Bryting av steinkull"
          )
        , ( "05.200"
          , "Bryting av brunkull"
          )
        , ( "06.100"
          , "Utvinning av råolje"
          )
        , ( "06.200"
          , "Utvinning av naturgass"
          )
        , ( "07.100"
          , "Bryting av jernmalm"
          )
        , ( "07.210"
          , "Bryting av uran- og thoriummalm"
          )
        , ( "07.290"
          , "Bryting av ikke-jernholdig malm ellers"
          )
        , ( "08.111"
          , "Bryting av stein til bygge- og anleggsvirksomhet"
          )
        , ( "08.112"
          , "Bryting av kalkstein, gips og kritt"
          )
        , ( "08.113"
          , "Bryting av skifer"
          )
        , ( "08.120"
          , "Utvinning fra grus- og sandtak, og utvinning av leire og kaolin"
          )
        , ( "08.910"
          , "Bryting og utvinning av kjemiske mineraler og gjødselsmineraler"
          )
        , ( "08.920"
          , "Stikking av torv"
          )
        , ( "08.930"
          , "Utvinning av salt"
          )
        , ( "08.990"
          , "Annen bryting og utvinning ikke nevnt annet sted"
          )
        , ( "09.101"
          , "Boretjenester tilknyttet utvinning av råolje og naturgass"
          )
        , ( "09.109"
          , "Andre tjenester tilknyttet utvinning av råolje og naturgass"
          )
        , ( "09.900"
          , "Tjenester tilknyttet annen bergverksdrift"
          )
        , ( "10.110"
          , "Bearbeiding og konservering av kjøtt"
          )
        , ( "10.120"
          , "Bearbeiding og konservering av fjørfekjøtt"
          )
        , ( "10.130"
          , "Produksjon av kjøtt- og fjørfevarer"
          )
        , ( "10.201"
          , "Produksjon av saltfisk, tørrfisk og klippfisk"
          )
        , ( "10.202"
          , "Frysing av fisk, fiskefileter, skalldyr og bløtdyr"
          )
        , ( "10.203"
          , "Produksjon av fiskehermetikk"
          )
        , ( "10.209"
          , "Slakting, bearbeiding og konservering av fisk og fiskevarer ellers"
          )
        , ( "10.310"
          , "Bearbeiding og konservering av poteter"
          )
        , ( "10.320"
          , "Produksjon av juice av frukt og grønnsaker"
          )
        , ( "10.390"
          , "Bearbeiding og konservering av frukt og grønnsaker ellers"
          )
        , ( "10.411"
          , "Produksjon av rå fiskeoljer og fett"
          )
        , ( "10.412"
          , "Produksjon av andre uraffinerte oljer og fett"
          )
        , ( "10.413"
          , "Produksjon av raffinerte oljer og fett"
          )
        , ( "10.420"
          , "Produksjon av margarin og lignende spiselige fettstoffer"
          )
        , ( "10.510"
          , "Produksjon av meierivarer"
          )
        , ( "10.520"
          , "Produksjon av iskrem"
          )
        , ( "10.610"
          , "Produksjon av kornvarer"
          )
        , ( "10.620"
          , "Produksjon av stivelse og stivelsesprodukter"
          )
        , ( "10.710"
          , "Produksjon av brød og ferske konditorvarer"
          )
        , ( "10.720"
          , "Produksjon av kavringer, kjeks og konserverte konditorvarer"
          )
        , ( "10.730"
          , "Produksjon av makaroni, nudler, couscous og lignende pastavarer"
          )
        , ( "10.810"
          , "Produksjon av sukker"
          )
        , ( "10.820"
          , "Produksjon av kakao, sjokolade og sukkervarer"
          )
        , ( "10.830"
          , "Bearbeiding av te og kaffe"
          )
        , ( "10.840"
          , "Produksjon av smakstilsettingsstoffer og krydderier"
          )
        , ( "10.850"
          , "Produksjon av ferdigmat"
          )
        , ( "10.860"
          , "Produksjon av homogeniserte matprodukter og diettmat"
          )
        , ( "10.890"
          , "Produksjon av næringsmidler ikke nevnt annet sted"
          )
        , ( "10.910"
          , "Produksjon av fôrvarer til husdyrhold"
          )
        , ( "10.920"
          , "Produksjon av fôrvarer til kjæledyr"
          )
        , ( "11.010"
          , "Destillering, rektifisering og blanding av sprit"
          )
        , ( "11.020"
          , "Produksjon av vin"
          )
        , ( "11.030"
          , "Produksjon av sider og annen fruktvin"
          )
        , ( "11.040"
          , "Produksjon av andre ikke-destillerte gjærede drikkevarer"
          )
        , ( "11.050"
          , "Produksjon av øl"
          )
        , ( "11.060"
          , "Produksjon av malt"
          )
        , ( "11.070"
          , "Produksjon av mineralvann, leskedrikker og annet vann på flaske"
          )
        , ( "12.000"
          , "Produksjon av tobakksvarer"
          )
        , ( "13.100"
          , "Bearbeiding og spinning av tekstilfibrer"
          )
        , ( "13.200"
          , "Veving av tekstiler"
          )
        , ( "13.300"
          , "Etterbehandling av tekstiler"
          )
        , ( "13.910"
          , "Produksjon av stoffer av trikotasje"
          )
        , ( "13.921"
          , "Produksjon av utstyrsvarer"
          )
        , ( "13.929"
          , "Produksjon av andre tekstilvarer, unntatt klær"
          )
        , ( "13.930"
          , "Produksjon av gulvtepper, -matter og -ryer"
          )
        , ( "13.940"
          , "Produksjon av tauverk og nett"
          )
        , ( "13.950"
          , "Produksjon av ikke-vevde tekstiler og tekstilvarer, unntatt klær"
          )
        , ( "13.960"
          , "Produksjon av tekstiler til teknisk og industriell bruk"
          )
        , ( "13.990"
          , "Produksjon av tekstiler ikke nevnt annet sted"
          )
        , ( "14.110"
          , "Produksjon av klær av lær"
          )
        , ( "14.120"
          , "Produksjon av arbeidstøy"
          )
        , ( "14.130"
          , "Produksjon av annet yttertøy"
          )
        , ( "14.140"
          , "Produksjon av undertøy og innertøy"
          )
        , ( "14.190"
          , "Produksjon av klær og tilbehør ellers"
          )
        , ( "14.200"
          , "Produksjon av pelsvarer"
          )
        , ( "14.310"
          , "Produksjon av strømpevarer"
          )
        , ( "14.390"
          , "Produksjon av andre klær av trikotasje"
          )
        , ( "15.110"
          , "Beredning av lær, og beredning og farging av pelsskinn"
          )
        , ( "15.120"
          , "Produksjon av reiseeffekter og salmakerartikler"
          )
        , ( "15.200"
          , "Produksjon av skotøy"
          )
        , ( "16.100"
          , "Saging, høvling og impregnering av tre"
          )
        , ( "16.210"
          , "Produksjon av finerplater og andre bygnings- og møbelplater av tre"
          )
        , ( "16.220"
          , "Produksjon av sammensatte parkettstaver"
          )
        , ( "16.231"
          , "Produksjon av monteringsferdige hus"
          )
        , ( "16.232"
          , "Produksjon av bygningsartikler"
          )
        , ( "16.240"
          , "Produksjon av treemballasje"
          )
        , ( "16.290"
          , "Produksjon av andre trevarer og varer av kork, strå og"
          )
        , ( "17.110"
          , "Produksjon av papirmasse"
          )
        , ( "17.120"
          , "Produksjon av papir og papp"
          )
        , ( "17.210"
          , "Produksjon av bølgepapp og emballasje av papir og papp"
          )
        , ( "17.220"
          , "Produksjon av husholdnings-, sanitær- og toalettartikler av papir"
          )
        , ( "17.230"
          , "Produksjon av kontorartikler av papir"
          )
        , ( "17.240"
          , "Produksjon av tapeter"
          )
        , ( "17.290"
          , "Produksjon av varer av papir og papp ellers"
          )
        , ( "18.110"
          , "Trykking av aviser"
          )
        , ( "18.120"
          , "Trykking ellers"
          )
        , ( "18.130"
          , "Ferdiggjøring før trykking og publisering"
          )
        , ( "18.140"
          , "Bokbinding og tilknyttede tjenester"
          )
        , ( "18.200"
          , "Reproduksjon av innspilte opptak"
          )
        , ( "19.100"
          , "Produksjon av kullprodukter"
          )
        , ( "19.200"
          , "Produksjon av raffinerte petroleumsprodukter"
          )
        , ( "20.110"
          , "Produksjon av industrigasser"
          )
        , ( "20.120"
          , "Produksjon av fargestoffer og pigmenter"
          )
        , ( "20.130"
          , "Produksjon av andre uorganiske kjemikalier"
          )
        , ( "20.140"
          , "Produksjon av andre organiske kjemiske råvarer"
          )
        , ( "20.150"
          , "Produksjon av gjødsel, nitrogenforbindelser og vekstjord"
          )
        , ( "20.160"
          , "Produksjon av basisplast"
          )
        , ( "20.170"
          , "Produksjon av syntetisk gummi"
          )
        , ( "20.200"
          , "Produksjon av plantevern- og skadedyrmidler og andre landbrukskjemiske"
          )
        , ( "20.300"
          , "Produksjon av maling og lakk, trykkfarger og tetningsmidler"
          )
        , ( "20.410"
          , "Produksjon av såpe og vaskemidler, rense- og polermidler"
          )
        , ( "20.420"
          , "Produksjon av parfyme og toalettartikler"
          )
        , ( "20.510"
          , "Produksjon av eksplosiver"
          )
        , ( "20.520"
          , "Produksjon av lim"
          )
        , ( "20.530"
          , "Produksjon av eteriske oljer"
          )
        , ( "20.590"
          , "Produksjon av kjemiske produkter ikke nevnt annet sted"
          )
        , ( "20.600"
          , "Produksjon av kunstfibrer"
          )
        , ( "21.100"
          , "Produksjon av farmasøytiske råvarer"
          )
        , ( "21.200"
          , "Produksjon av farmasøytiske preparater"
          )
        , ( "22.110"
          , "Produksjon av gummidekk og slanger til gummidekk, og regummiering og"
          )
        , ( "22.190"
          , "Produksjon av gummiprodukter ellers"
          )
        , ( "22.210"
          , "Produksjon av halvfabrikater av plast"
          )
        , ( "22.220"
          , "Produksjon av plastemballasje"
          )
        , ( "22.230"
          , "Produksjon av byggevarer av plast"
          )
        , ( "22.290"
          , "Produksjon av plastprodukter ellers"
          )
        , ( "23.110"
          , "Produksjon av planglass"
          )
        , ( "23.120"
          , "Bearbeiding av planglass"
          )
        , ( "23.130"
          , "Produksjon av emballasje og husholdningsartikler av glass og krystall"
          )
        , ( "23.140"
          , "Produksjon av glassfibrer"
          )
        , ( "23.190"
          , "Produksjon av teknisk glass og andre glassvarer"
          )
        , ( "23.200"
          , "Produksjon av ildfaste produkter"
          )
        , ( "23.310"
          , "Produksjon av keramiske vegg- og gulvfliser"
          )
        , ( "23.320"
          , "Produksjon av murstein, teglstein og andre byggevarer av brent leire"
          )
        , ( "23.410"
          , "Produksjon av keramiske husholdningsartikler og dekorasjonsgjenstander"
          )
        , ( "23.420"
          , "Produksjon av sanitærutstyr av keramisk materiale"
          )
        , ( "23.430"
          , "Produksjon av isolatorer og isoleringsdeler av keramisk materiale"
          )
        , ( "23.440"
          , "Produksjon av andre keramiske produkter for teknisk bruk"
          )
        , ( "23.490"
          , "Produksjon av andre keramiske produkter"
          )
        , ( "23.510"
          , "Produksjon av sement"
          )
        , ( "23.520"
          , "Produksjon av kalk og gips"
          )
        , ( "23.610"
          , "Produksjon av betongprodukter for bygge- og anleggsvirksomhet"
          )
        , ( "23.620"
          , "Produksjon av gipsprodukter for bygge- og anleggsvirksomhet"
          )
        , ( "23.630"
          , "Produksjon av ferdigblandet betong"
          )
        , ( "23.640"
          , "Produksjon av mørtel"
          )
        , ( "23.650"
          , "Produksjon av fibersement"
          )
        , ( "23.690"
          , "Produksjon av betong-, sement- og gipsprodukter ellers"
          )
        , ( "23.700"
          , "Hogging og bearbeiding av monument- og bygningsstein"
          )
        , ( "23.910"
          , "Produksjon av slipestoffer"
          )
        , ( "23.990"
          , "Produksjon av ikke-metallholdige mineralprodukter ikke nevnt annet"
          )
        , ( "24.101"
          , "Produksjon av jern og stål"
          )
        , ( "24.102"
          , "Produksjon av ferrolegeringer"
          )
        , ( "24.200"
          , "Produksjon av andre rør og rørdeler av stål"
          )
        , ( "24.310"
          , "Kaldtrekking av stenger og profiler"
          )
        , ( "24.320"
          , "Kaldvalsing av bånd"
          )
        , ( "24.330"
          , "Kaldvalsing og pressing av profilerte plater og profiler"
          )
        , ( "24.340"
          , "Kaldtrekking av tråd"
          )
        , ( "24.410"
          , "Produksjon av edelmetaller"
          )
        , ( "24.421"
          , "Produksjon av primæraluminium"
          )
        , ( "24.422"
          , "Produksjon av halvfabrikater av aluminium"
          )
        , ( "24.430"
          , "Produksjon av bly, sink og tinn"
          )
        , ( "24.440"
          , "Produksjon av kobber"
          )
        , ( "24.450"
          , "Produksjon av ikke-jernholdige metaller ellers"
          )
        , ( "24.460"
          , "Produksjon av kjernebrensel"
          )
        , ( "24.510"
          , "Støping av jern"
          )
        , ( "24.520"
          , "Støping av stål"
          )
        , ( "24.530"
          , "Støping av lettmetaller"
          )
        , ( "24.540"
          , "Støping av andre ikke-jernholdige metaller"
          )
        , ( "25.110"
          , "Produksjon av metallkonstruksjoner og deler"
          )
        , ( "25.120"
          , "Produksjon av dører og vinduer av metall"
          )
        , ( "25.210"
          , "Produksjon av radiatorer og kjeler til sentralvarmeanlegg"
          )
        , ( "25.290"
          , "Produksjon av andre tanker, cisterner og beholdere av metall"
          )
        , ( "25.300"
          , "Produksjon av dampkjeler, unntatt kjeler til sentralvarmeanlegg"
          )
        , ( "25.400"
          , "Produksjon av våpen og ammunisjon"
          )
        , ( "25.500"
          , "Smiing, stansing og valsing av metall, og pulvermetallurgi"
          )
        , ( "25.610"
          , "Overflatebehandling av metaller"
          )
        , ( "25.620"
          , "Bearbeiding av metaller"
          )
        , ( "25.710"
          , "Produksjon av kjøkkenredskaper og skjære- og klipperedskaper"
          )
        , ( "25.720"
          , "Produksjon av låser og beslag"
          )
        , ( "25.730"
          , "Produksjon av håndverktøy"
          )
        , ( "25.910"
          , "Produksjon av stålfat og lignende beholdere av jern og stål"
          )
        , ( "25.920"
          , "Produksjon av emballasje av lettmetall"
          )
        , ( "25.930"
          , "Produksjon av varer av metalltråd, kjetting og fjærer"
          )
        , ( "25.940"
          , "Produksjon av bolter og skruer"
          )
        , ( "25.990"
          , "Produksjon av metallvarer ikke nevnt annet sted"
          )
        , ( "26.110"
          , "Produksjon av elektroniske komponenter"
          )
        , ( "26.120"
          , "Produksjon av kretskort"
          )
        , ( "26.200"
          , "Produksjon av datamaskiner og tilleggsutstyr"
          )
        , ( "26.300"
          , "Produksjon av kommunikasjonsutstyr"
          )
        , ( "26.400"
          , "Produksjon av elektronikk til husholdningsbruk"
          )
        , ( "26.510"
          , "Produksjon av måle-, kontroll- og navigasjonsinstrumenter"
          )
        , ( "26.520"
          , "Produksjon av klokker og ur"
          )
        , ( "26.600"
          , "Produksjon av strålingsutstyr, elektromedisinsk- og elektroterapeutisk"
          )
        , ( "26.700"
          , "Produksjon av optiske instrumenter og fotografisk utstyr"
          )
        , ( "26.800"
          , "Produksjon av magnetiske og optiske media"
          )
        , ( "27.110"
          , "Produksjon av elektromotorer, generatorer og transformatorer"
          )
        , ( "27.120"
          , "Produksjon av elektriske fordelings- og kontrolltavler og paneler"
          )
        , ( "27.200"
          , "Produksjon av batterier og akkumulatorer"
          )
        , ( "27.310"
          , "Produksjon av optiske fiberkabler"
          )
        , ( "27.320"
          , "Produksjon av andre elektroniske og elektriske ledninger og kabler"
          )
        , ( "27.330"
          , "Produksjon av ledningsmateriell"
          )
        , ( "27.400"
          , "Produksjon av belysningsutstyr"
          )
        , ( "27.510"
          , "Produksjon av elektriske husholdningsmaskiner og -apparater"
          )
        , ( "27.520"
          , "Produksjon av ikke-elektriske husholdningsmaskiner og -apparater"
          )
        , ( "27.900"
          , "Produksjon av annet elektrisk utstyr"
          )
        , ( "28.110"
          , "Produksjon av motorer og turbiner, unntatt motorer til luftfartøyer og"
          )
        , ( "28.120"
          , "Produksjon av komponenter til hydraulisk og pneumatisk utstyr"
          )
        , ( "28.130"
          , "Produksjon av pumper og kompressorer ellers"
          )
        , ( "28.140"
          , "Produksjon av kraner og ventiler ellers"
          )
        , ( "28.150"
          , "Produksjon av lagre, gir, tannhjulsutvekslinger og andre innretninger"
          )
        , ( "28.210"
          , "Produksjon av industri- og laboratorieovner samt brennere"
          )
        , ( "28.221"
          , "Produksjon av løfte- og håndteringsutstyr til skip og båter"
          )
        , ( "28.229"
          , "Produksjon av løfte- og håndteringsutstyr ellers"
          )
        , ( "28.230"
          , "Produksjon av kontormaskiner og utstyr (unntatt datamaskiner og"
          )
        , ( "28.240"
          , "Produksjon av motordrevet håndverktøy"
          )
        , ( "28.250"
          , "Produksjon av kjøle- og ventilasjonsanlegg, unntatt til"
          )
        , ( "28.290"
          , "Produksjon av maskiner og utstyr til generell bruk, ikke nevnt annet"
          )
        , ( "28.300"
          , "Produksjon av jordbruks- og skogbruksmaskiner"
          )
        , ( "28.410"
          , "Produksjon av maskinverktøy til metallbearbeiding"
          )
        , ( "28.490"
          , "Produksjon av maskinverktøy ikke nevnt annet sted"
          )
        , ( "28.910"
          , "Produksjon av maskiner og utstyr til metallurgisk industri"
          )
        , ( "28.920"
          , "Produksjon av maskiner og utstyr til bergverksdrift og bygge- og"
          )
        , ( "28.930"
          , "Produksjon av maskiner og utstyr til nærings- og"
          )
        , ( "28.940"
          , "Produksjon av maskiner og utstyr til tekstil-, konfeksjons- og lærvare"
          )
        , ( "28.950"
          , "Produksjon av maskiner og utstyr til papir- og pappvareindustri"
          )
        , ( "28.960"
          , "Produksjon av maskiner og utstyr til plast- og gummiindustri"
          )
        , ( "28.990"
          , "Produksjon av spesialmaskiner ikke nevnt annet sted"
          )
        , ( "29.100"
          , "Produksjon av motorvogner"
          )
        , ( "29.200"
          , "Produksjon av karosserier og tilhengere"
          )
        , ( "29.310"
          , "Produksjon av elektrisk og elektronisk utstyr til motorvogner"
          )
        , ( "29.320"
          , "Produksjon av andre deler og annet utstyr til motorvogner"
          )
        , ( "30.111"
          , "Bygging av skip og skrog over 100 br.tonn"
          )
        , ( "30.112"
          , "Bygging av skip under 100 br.tonn"
          )
        , ( "30.113"
          , "Bygging av oljeplattformer og moduler"
          )
        , ( "30.114"
          , "Produksjon av annet flytende materiell"
          )
        , ( "30.115"
          , "Innrednings- og installasjonsarbeid utført på skip over 100 br.tonn"
          )
        , ( "30.116"
          , "Innrednings- og installasjonsarbeid utført på borerigger og moduler"
          )
        , ( "30.120"
          , "Bygging av fritidsbåter"
          )
        , ( "30.200"
          , "Produksjon av lokomotiver og annet rullende materiell til jernbane og"
          )
        , ( "30.300"
          , "Produksjon av luftfartøyer og romfartøyer og lignende utstyr"
          )
        , ( "30.400"
          , "Produksjon av militære stridskjøretøyer"
          )
        , ( "30.910"
          , "Produksjon av motorsykler"
          )
        , ( "30.920"
          , "Produksjon av sykler og invalidevogner"
          )
        , ( "30.990"
          , "Produksjon av andre transportmidler ikke nevnt annet sted"
          )
        , ( "31.010"
          , "Produksjon av kontor- og butikkmøbler"
          )
        , ( "31.020"
          , "Produksjon av kjøkkenmøbler"
          )
        , ( "31.030"
          , "Produksjon av madrasser"
          )
        , ( "31.090"
          , "Produksjon av møbler ellers"
          )
        , ( "32.110"
          , "Preging av mynter og medaljer"
          )
        , ( "32.120"
          , "Produksjon av gull- og sølvvarer og lignende artikler"
          )
        , ( "32.130"
          , "Produksjon av bijouteri og lignende artikler"
          )
        , ( "32.200"
          , "Produksjon av musikkinstrumenter"
          )
        , ( "32.300"
          , "Produksjon av sportsartikler"
          )
        , ( "32.400"
          , "Produksjon av spill og leker"
          )
        , ( "32.500"
          , "Produksjon av medisinske og tanntekniske instrumenter og utstyr"
          )
        , ( "32.910"
          , "Produksjon av koster og børster"
          )
        , ( "32.990"
          , "Annen industriproduksjon ikke nevnt annet sted"
          )
        , ( "33.110"
          , "Reparasjon av bearbeidede metallprodukter"
          )
        , ( "33.120"
          , "Reparasjon av maskiner"
          )
        , ( "33.130"
          , "Reparasjon av elektronisk og optisk utstyr"
          )
        , ( "33.140"
          , "Reparasjon av elektrisk utstyr"
          )
        , ( "33.150"
          , "Reparasjon og vedlikehold av skip og båter"
          )
        , ( "33.160"
          , "Reparasjon og vedlikehold av luftfartøyer og romfartøyer"
          )
        , ( "33.170"
          , "Reparasjon og vedlikehold av andre transportmidler"
          )
        , ( "33.190"
          , "Reparasjon av annet utstyr"
          )
        , ( "33.200"
          , "Installasjon av industrimaskiner og -utstyr"
          )
        , ( "35.111"
          , "Produksjon av elektrisitet fra vannkraft"
          )
        , ( "35.112"
          , "Produksjon av elektrisitet fra vindkraft"
          )
        , ( "35.113"
          , "Produksjon av elektrisitet fra biobrensel, avfallsforbrenning og"
          )
        , ( "35.114"
          , "Produksjon av elektrisitet fra naturgass"
          )
        , ( "35.119"
          , "Produksjon av elektrisitet ellers"
          )
        , ( "35.120"
          , "Overføring av elektrisitet"
          )
        , ( "35.130"
          , "Distribusjon av elektrisitet"
          )
        , ( "35.140"
          , "Handel med elektrisitet"
          )
        , ( "35.210"
          , "Produksjon av gass"
          )
        , ( "35.220"
          , "Distribusjon av gass gjennom ledningsnett"
          )
        , ( "35.230"
          , "Handel med gass gjennom ledningsnett"
          )
        , ( "35.300"
          , "Damp- og varmtvannsforsyning"
          )
        , ( "36.000"
          , "Uttak fra kilde, rensing og distribusjon av vann"
          )
        , ( "37.000"
          , "Oppsamling og behandling av avløpsvann"
          )
        , ( "38.110"
          , "Innsamling av ikke-farlig avfall"
          )
        , ( "38.120"
          , "Innsamling av farlig avfall"
          )
        , ( "38.210"
          , "Behandling og disponering av ikke-farlig avfall"
          )
        , ( "38.220"
          , "Behandling og disponering av farlig avfall"
          )
        , ( "38.310"
          , "Demontering av vrakede gjenstander"
          )
        , ( "38.320"
          , "Sortering og bearbeiding av avfall for materialgjenvinning"
          )
        , ( "39.000"
          , "Miljørydding, miljørensing og lignende virksomhet"
          )
        , ( "41.101"
          , "Boligbyggelag"
          )
        , ( "41.109"
          , "Utvikling og salg av egen fast eiendom ellers"
          )
        , ( "41.200"
          , "Oppføring av bygninger"
          )
        , ( "42.110"
          , "Bygging av veier og motorveier"
          )
        , ( "42.120"
          , "Bygging av jernbaner og undergrunnsbaner"
          )
        , ( "42.130"
          , "Bygging av bruer og tunneler"
          )
        , ( "42.210"
          , "Bygging av vann- og kloakkanlegg"
          )
        , ( "42.220"
          , "Bygging av anlegg for elektrisitet og telekommunikasjon"
          )
        , ( "42.910"
          , "Bygging av havne- og damanlegg"
          )
        , ( "42.990"
          , "Bygging av andre anlegg ikke nevnt annet sted"
          )
        , ( "43.110"
          , "Riving av bygninger og andre konstruksjoner"
          )
        , ( "43.120"
          , "Grunnarbeid"
          )
        , ( "43.130"
          , "Prøveboring"
          )
        , ( "43.210"
          , "Elektrisk installasjonsarbeid"
          )
        , ( "43.290"
          , "Annet installasjonsarbeid"
          )
        , ( "43.310"
          , "Stukkatørarbeid og pussing"
          )
        , ( "43.320"
          , "Snekkerarbeid"
          )
        , ( "43.330"
          , "Gulvlegging og tapetsering"
          )
        , ( "43.341"
          , "Malerarbeid"
          )
        , ( "43.342"
          , "Glassarbeid"
          )
        , ( "43.390"
          , "Annen ferdiggjøring av bygninger"
          )
        , ( "43.911"
          , "Blikkenslagerarbeid på tak"
          )
        , ( "43.919"
          , "Takarbeid ellers"
          )
        , ( "43.990"
          , "Annen spesialisert bygge- og anleggsvirksomhet"
          )
        , ( "45.111"
          , "Agentur- og engroshandel med biler og lette motorvogner, unntatt"
          )
        , ( "45.112"
          , "Detaljhandel med biler og lette motorvogner, unntatt motorsykler"
          )
        , ( "45.191"
          , "Agentur- og engroshandel med andre motorvogner, unntatt motorsykler"
          )
        , ( "45.192"
          , "Detaljhandel med andre motorvogner, unntatt motorsykler"
          )
        , ( "45.200"
          , "Vedlikehold og reparasjon av motorvogner, unntatt motorsykler"
          )
        , ( "45.310"
          , "Agentur- og engroshandel med deler og utstyr til motorvogner, unntatt"
          )
        , ( "45.320"
          , "Detaljhandel med deler og utstyr til motorvogner, unntatt motorsykler"
          )
        , ( "45.401"
          , "Agentur- og engroshandel med motorsykler, deler og utstyr"
          )
        , ( "45.402"
          , "Detaljhandel med motorsykler, deler og utstyr"
          )
        , ( "45.403"
          , "Vedlikehold og reparasjon av motorsykler"
          )
        , ( "46.110"
          , "Agenturhandel med jordbruksråvarer, levende dyr, tekstilråvarer og"
          )
        , ( "46.120"
          , "Agenturhandel med brensel, drivstoff, malm, metaller og"
          )
        , ( "46.130"
          , "Agenturhandel med tømmer, trelast og byggevarer"
          )
        , ( "46.140"
          , "Agenturhandel med maskiner, produksjonsutstyr, båter og luftfartøyer"
          )
        , ( "46.150"
          , "Agenturhandel med møbler, husholdningsvarer og jernvarer"
          )
        , ( "46.160"
          , "Agenturhandel med tekstiler, klær, pelsskinn, skotøy og lærvarer"
          )
        , ( "46.170"
          , "Agenturhandel med nærings- og nytelsesmidler"
          )
        , ( "46.180"
          , "Agenturhandel med spesialisert vareutvalg ellers"
          )
        , ( "46.190"
          , "Agenturhandel med bredt vareutvalg"
          )
        , ( "46.210"
          , "Engroshandel med korn, råtobakk, såvarer og fôrvarer"
          )
        , ( "46.220"
          , "Engroshandel med blomster og planter"
          )
        , ( "46.230"
          , "Engroshandel med levende dyr"
          )
        , ( "46.240"
          , "Engroshandel med huder, skinn og lær"
          )
        , ( "46.310"
          , "Engroshandel med frukt og grønnsaker"
          )
        , ( "46.320"
          , "Engroshandel med kjøtt og kjøttvarer"
          )
        , ( "46.330"
          , "Engroshandel med meierivarer, egg, matolje og -fett"
          )
        , ( "46.341"
          , "Engroshandel med vin og brennevin"
          )
        , ( "46.349"
          , "Engroshandel med drikkevarer ellers"
          )
        , ( "46.350"
          , "Engroshandel med tobakksvarer"
          )
        , ( "46.360"
          , "Engroshandel med sukker, sjokolade og sukkervarer"
          )
        , ( "46.370"
          , "Engroshandel med kaffe, te, kakao og krydder"
          )
        , ( "46.381"
          , "Engroshandel med fisk, skalldyr og bløtdyr"
          )
        , ( "46.389"
          , "Engroshandel med spesialisert utvalg av nærings- og nytelsesmidler"
          )
        , ( "46.390"
          , "Engroshandel med bredt utvalg av nærings- og nytelsesmidler"
          )
        , ( "46.410"
          , "Engroshandel med tekstiler og utstyrsvarer"
          )
        , ( "46.421"
          , "Engroshandel med klær"
          )
        , ( "46.422"
          , "Engroshandel med skotøy"
          )
        , ( "46.431"
          , "Engroshandel med elektriske husholdningsapparater og -maskiner"
          )
        , ( "46.432"
          , "Engroshandel med radio og fjernsyn"
          )
        , ( "46.433"
          , "Engroshandel med plater, musikk- og videokassetter og CD- og"
          )
        , ( "46.434"
          , "Engroshandel med fotoutstyr"
          )
        , ( "46.435"
          , "Engroshandel med optiske artikler"
          )
        , ( "46.441"
          , "Engroshandel med kjøkkenutstyr, glass og steintøy"
          )
        , ( "46.442"
          , "Engroshandel med rengjøringsmidler"
          )
        , ( "46.450"
          , "Engroshandel med parfyme og kosmetikk"
          )
        , ( "46.460"
          , "Engroshandel med sykepleie- og apotekvarer"
          )
        , ( "46.471"
          , "Engroshandel med møbler"
          )
        , ( "46.472"
          , "Engroshandel med gulvtepper"
          )
        , ( "46.473"
          , "Engroshandel med belysningsutstyr"
          )
        , ( "46.481"
          , "Engroshandel med klokker og ur"
          )
        , ( "46.482"
          , "Engroshandel med gull- og sølvvarer"
          )
        , ( "46.491"
          , "Engroshandel med bøker, aviser og blader"
          )
        , ( "46.492"
          , "Engroshandel med reiseeffekter og lærvarer"
          )
        , ( "46.493"
          , "Engroshandel med fritidsbåter og -utstyr"
          )
        , ( "46.494"
          , "Engroshandel med sportsutstyr"
          )
        , ( "46.495"
          , "Engroshandel med spill og leker"
          )
        , ( "46.499"
          , "Engroshandel med husholdningsvarer og varer til personlig bruk ikke"
          )
        , ( "46.510"
          , "Engroshandel med datamaskiner, tilleggsutstyr til datamaskiner samt"
          )
        , ( "46.520"
          , "Engroshandel med elektronikkutstyr og telekommunikasjonsutstyr samt"
          )
        , ( "46.610"
          , "Engroshandel med maskiner og utstyr til jordbruk og skogbruk"
          )
        , ( "46.620"
          , "Engroshandel med maskinverktøy"
          )
        , ( "46.630"
          , "Engroshandel med maskiner og utstyr til bergverksdrift, olje- og"
          )
        , ( "46.640"
          , "Engroshandel med maskiner og utstyr til tekstilproduksjon"
          )
        , ( "46.650"
          , "Engroshandel med kontormøbler"
          )
        , ( "46.660"
          , "Engroshandel med maskiner og utstyr til kontor ellers"
          )
        , ( "46.691"
          , "Engroshandel med maskiner og utstyr til kraftproduksjon og"
          )
        , ( "46.692"
          , "Engroshandel med skipsutstyr og fiskeredskap"
          )
        , ( "46.693"
          , "Engroshandel med maskiner og utstyr til industri ellers"
          )
        , ( "46.694"
          , "Engroshandel med maskiner og utstyr til handel, transport og"
          )
        , ( "46.710"
          , "Engroshandel med drivstoff og brensel"
          )
        , ( "46.720"
          , "Engroshandel med metaller og metallholdig malm"
          )
        , ( "46.731"
          , "Engroshandel med tømmer"
          )
        , ( "46.732"
          , "Engroshandel med trelast"
          )
        , ( "46.733"
          , "Engroshandel med fargevarer"
          )
        , ( "46.739"
          , "Engroshandel med byggevarer ikke nevnt annet sted"
          )
        , ( "46.740"
          , "Engroshandel med jernvarer, rørleggerartikler og oppvarmingsutstyr"
          )
        , ( "46.750"
          , "Engroshandel med kjemiske produkter"
          )
        , ( "46.761"
          , "Engroshandel med papir og papp"
          )
        , ( "46.769"
          , "Engroshandel med innsatsvarer ikke nevnt annet sted"
          )
        , ( "46.770"
          , "Engroshandel med avfall og skrap"
          )
        , ( "46.900"
          , "Uspesifisert engroshandel"
          )
        , ( "47.111"
          , "Butikkhandel med bredt vareutvalg med hovedvekt på nærings- og"
          )
        , ( "47.112"
          , "Kioskhandel med bredt vareutvalg med hovedvekt på nærings- og"
          )
        , ( "47.190"
          , "Butikkhandel med bredt vareutvalg ellers"
          )
        , ( "47.210"
          , "Butikkhandel med frukt og grønnsaker"
          )
        , ( "47.220"
          , "Butikkhandel med kjøtt og kjøttvarer"
          )
        , ( "47.230"
          , "Butikkhandel med fisk, skalldyr og bløtdyr"
          )
        , ( "47.241"
          , "Butikkhandel med bakervarer og konditorvarer"
          )
        , ( "47.242"
          , "Butikkhandel med sukkervarer"
          )
        , ( "47.251"
          , "Butikkhandel med vin og brennevin"
          )
        , ( "47.259"
          , "Butikkhandel med drikkevarer ellers"
          )
        , ( "47.260"
          , "Butikkhandel med tobakksvarer"
          )
        , ( "47.291"
          , "Butikkhandel med helsekost"
          )
        , ( "47.292"
          , "Butikkhandel med kaffe og te"
          )
        , ( "47.299"
          , "Butikkhandel med nærings- og nytelsesmidler ikke nevnt annet sted"
          )
        , ( "47.300"
          , "Detaljhandel med drivstoff til motorvogner"
          )
        , ( "47.410"
          , "Butikkhandel med datamaskiner og utstyr til datamaskiner"
          )
        , ( "47.420"
          , "Butikkhandel med telekommunikasjonsutstyr"
          )
        , ( "47.430"
          , "Butikkhandel med audio- og videoutstyr"
          )
        , ( "47.510"
          , "Butikkhandel med tekstiler og utstyrsvarer"
          )
        , ( "47.521"
          , "Butikkhandel med bredt utvalg av jernvarer, fargevarer og andre"
          )
        , ( "47.522"
          , "Butikkhandel med jernvarer"
          )
        , ( "47.523"
          , "Butikkhandel med fargevarer"
          )
        , ( "47.524"
          , "Butikkhandel med trelast"
          )
        , ( "47.529"
          , "Butikkhandel med byggevarer ikke nevnt annet sted"
          )
        , ( "47.531"
          , "Butikkhandel med tapeter og gulvbelegg"
          )
        , ( "47.532"
          , "Butikkhandel med tepper"
          )
        , ( "47.533"
          , "Butikkhandel med gardiner"
          )
        , ( "47.540"
          , "Butikkhandel med elektriske husholdningsapparater"
          )
        , ( "47.591"
          , "Butikkhandel med møbler"
          )
        , ( "47.592"
          , "Butikkhandel med belysningsutstyr"
          )
        , ( "47.593"
          , "Butikkhandel med kjøkkenutstyr, glass og steintøy"
          )
        , ( "47.594"
          , "Butikkhandel med musikkinstrumenter og noter"
          )
        , ( "47.599"
          , "Butikkhandel med innredningsartikler ikke nevnt annet sted"
          )
        , ( "47.610"
          , "Butikkhandel med bøker"
          )
        , ( "47.620"
          , "Butikkhandel med aviser og papirvarer"
          )
        , ( "47.630"
          , "Butikkhandel med innspillinger av musikk og video"
          )
        , ( "47.641"
          , "Butikkhandel med sportsutstyr"
          )
        , ( "47.642"
          , "Butikkhandel med fritidsbåter og -utstyr"
          )
        , ( "47.650"
          , "Butikkhandel med spill og leker"
          )
        , ( "47.710"
          , "Butikkhandel med klær"
          )
        , ( "47.721"
          , "Butikkhandel med skotøy"
          )
        , ( "47.722"
          , "Butikkhandel med reiseeffekter av lær og lærimitasjoner og varer av"
          )
        , ( "47.730"
          , "Butikkhandel med apotekvarer"
          )
        , ( "47.740"
          , "Butikkhandel med medisinske og ortopediske artikler"
          )
        , ( "47.750"
          , "Butikkhandel med kosmetikk og toalettartikler"
          )
        , ( "47.761"
          , "Butikkhandel med blomster og planter"
          )
        , ( "47.762"
          , "Butikkhandel med kjæledyr og fôr til kjæledyr"
          )
        , ( "47.771"
          , "Butikkhandel med ur og klokker"
          )
        , ( "47.772"
          , "Butikkhandel med gull- og sølvvarer"
          )
        , ( "47.781"
          , "Butikkhandel med fotoutstyr"
          )
        , ( "47.782"
          , "Butikkhandel med optiske artikler"
          )
        , ( "47.789"
          , "Butikkhandel ikke nevnt annet sted"
          )
        , ( "47.791"
          , "Butikkhandel med antikviteter"
          )
        , ( "47.792"
          , "Butikkhandel med brukte klær"
          )
        , ( "47.799"
          , "Butikkhandel med brukte varer ellers"
          )
        , ( "47.810"
          , "Torghandel med næringsmidler, drikkevarer og tobakksvarer"
          )
        , ( "47.820"
          , "Torghandel med tekstiler, klær, skotøy og utstyrsvarer"
          )
        , ( "47.890"
          , "Torghandel med andre varer"
          )
        , ( "47.911"
          , "Postordre-/Internetthandel med bredt vareutvalg"
          )
        , ( "47.912"
          , "Postordre-/Internetthandel med tekstiler, utstyrsvarer, klær, skotøy,"
          )
        , ( "47.913"
          , "Postordre-/Internetthandel med belysningsutstyr, kjøkkenutstyr, møbler"
          )
        , ( "47.914"
          , "Postordre-/Internetthandel med elektriske husholdningsapparater,"
          )
        , ( "47.915"
          , "Postordre-/Internetthandel med bøker, papir, aviser og blader"
          )
        , ( "47.916"
          , "Postordre-/Internetthandel med IKT-utstyr"
          )
        , ( "47.917"
          , "Postordre-/Internetthandel med helsekost"
          )
        , ( "47.919"
          , "Postordre-/Internetthandel med annet spesialisert vareutvalg"
          )
        , ( "47.990"
          , "Detaljhandel utenom utsalgssted ellers"
          )
        , ( "49.100"
          , "Passasjertransport med jernbane"
          )
        , ( "49.200"
          , "Godstransport med jernbane"
          )
        , ( "49.311"
          , "Rutebiltransport i by- og forstadsområde"
          )
        , ( "49.312"
          , "Transport med sporveis- og forstadsbane"
          )
        , ( "49.320"
          , "Drosjebiltransport"
          )
        , ( "49.391"
          , "Rutebiltransport utenfor by- og forstadsområde"
          )
        , ( "49.392"
          , "Turbiltransport"
          )
        , ( "49.393"
          , "Transport med taubaner, kabelbaner og skiheiser"
          )
        , ( "49.410"
          , "Godstransport på vei"
          )
        , ( "49.420"
          , "Flyttetransport"
          )
        , ( "49.500"
          , "Rørtransport"
          )
        , ( "50.101"
          , "Utenriks sjøfart med passasjerer"
          )
        , ( "50.102"
          , "Innenlandske kystruter med passasjerer"
          )
        , ( "50.109"
          , "Kysttrafikk ellers med passasjerer"
          )
        , ( "50.201"
          , "Utenriks sjøfart med gods"
          )
        , ( "50.202"
          , "Innenriks sjøfart med gods"
          )
        , ( "50.203"
          , "Slepebåter"
          )
        , ( "50.204"
          , "Forsyning og andre sjøtransporttjenester for offshore"
          )
        , ( "50.300"
          , "Passasjertransport på elver og innsjøer"
          )
        , ( "50.400"
          , "Godstransport på elver og innsjøer"
          )
        , ( "51.100"
          , "Lufttransport med passasjerer"
          )
        , ( "51.210"
          , "Lufttransport med gods"
          )
        , ( "51.220"
          , "Romfart"
          )
        , ( "52.100"
          , "Lagring"
          )
        , ( "52.211"
          , "Drift av gods- og transportsentraler"
          )
        , ( "52.212"
          , "Drift av parkeringsplasser og parkeringshus"
          )
        , ( "52.213"
          , "Drift av bomstasjoner"
          )
        , ( "52.214"
          , "Drift av taxisentraler og annen formidling av persontransport"
          )
        , ( "52.219"
          , "Tjenester tilknyttet landtransport ellers"
          )
        , ( "52.221"
          , "Drift av havne- og kaianlegg"
          )
        , ( "52.222"
          , "Redningstjeneste"
          )
        , ( "52.223"
          , "Forsyningsbaser"
          )
        , ( "52.229"
          , "Tjenester tilknyttet sjøtransport ellers"
          )
        , ( "52.230"
          , "Andre tjenester tilknyttet lufttransport"
          )
        , ( "52.240"
          , "Lasting og lossing"
          )
        , ( "52.291"
          , "Spedisjon"
          )
        , ( "52.292"
          , "Skipsmegling"
          )
        , ( "52.293"
          , "Flymegling"
          )
        , ( "52.299"
          , "Transportformidling ellers"
          )
        , ( "53.100"
          , "Landsdekkende posttjenester"
          )
        , ( "53.200"
          , "Andre post- og budtjenester"
          )
        , ( "55.101"
          , "Drift av hoteller, pensjonater og moteller med restaurant"
          )
        , ( "55.102"
          , "Drift av hoteller, pensjonater og moteller uten restaurant"
          )
        , ( "55.201"
          , "Drift av vandrerhjem"
          )
        , ( "55.202"
          , "Drift av ferieleiligheter"
          )
        , ( "55.900"
          , "Annen overnatting"
          )
        , ( "56.101"
          , "Drift av restauranter og kafeer"
          )
        , ( "56.102"
          , "Drift av gatekjøkken"
          )
        , ( "56.210"
          , "Cateringvirksomhet"
          )
        , ( "56.290"
          , "Kantiner drevet som selvstendig virksomhet"
          )
        , ( "56.301"
          , "Drift av puber"
          )
        , ( "56.309"
          , "Drift av barer ellers"
          )
        , ( "58.110"
          , "Utgivelse av bøker"
          )
        , ( "58.120"
          , "Utgivelse av kataloger og adresselister"
          )
        , ( "58.130"
          , "Utgivelse av aviser"
          )
        , ( "58.140"
          , "Utgivelse av blader og tidsskrifter"
          )
        , ( "58.190"
          , "Forlagsvirksomhet ellers"
          )
        , ( "58.210"
          , "Utgivelse av programvare for dataspill"
          )
        , ( "58.290"
          , "Utgivelse av annen programvare"
          )
        , ( "59.110"
          , "Produksjon av film, video og fjernsynsprogrammer"
          )
        , ( "59.120"
          , "Etterarbeid knyttet til produksjon av film, video og fjernsynsprogramm"
          )
        , ( "59.130"
          , "Distribusjon av film, video og fjernsynsprogrammer"
          )
        , ( "59.140"
          , "Filmframvisning"
          )
        , ( "59.200"
          , "Produksjon og utgivelse av musikk- og lydopptak"
          )
        , ( "60.100"
          , "Radiokringkasting"
          )
        , ( "60.200"
          , "Fjernsynskringkasting"
          )
        , ( "61.100"
          , "Kabelbasert telekommunikasjon"
          )
        , ( "61.200"
          , "Trådløs telekommunikasjon"
          )
        , ( "61.300"
          , "Satellittbasert telekommunikasjon"
          )
        , ( "61.900"
          , "Telekommunikasjon ellers"
          )
        , ( "62.010"
          , "Programmeringstjenester"
          )
        , ( "62.020"
          , "Konsulentvirksomhet tilknyttet informasjonsteknologi"
          )
        , ( "62.030"
          , "Forvaltning og drift av IT-systemer"
          )
        , ( "62.090"
          , "Andre tjenester tilknyttet informasjonsteknologi"
          )
        , ( "63.110"
          , "Databehandling, datalagring og tilknyttede tjenester"
          )
        , ( "63.120"
          , "Drift av web-portaler"
          )
        , ( "63.910"
          , "Nyhetsbyråer"
          )
        , ( "63.990"
          , "Andre informasjonstjenester ikke nevnt annet sted"
          )
        , ( "64.110"
          , "Sentralbankvirksomhet"
          )
        , ( "64.190"
          , "Bankvirksomhet ellers"
          )
        , ( "64.201"
          , "Finansielle holdingselskaper"
          )
        , ( "64.202"
          , "Spesielle holdingselskaper"
          )
        , ( "64.301"
          , "Verdipapirfond"
          )
        , ( "64.302"
          , "Investeringsselskaper/-fond åpne for allmennheten"
          )
        , ( "64.920"
          , "Annen kredittgivning"
          )
        , ( "64.990"
          , "Annen finansieringsvirksomhet ikke nevnt annet sted"
          )
        , ( "65.110"
          , "Livsforsikring"
          )
        , ( "65.120"
          , "Skadeforsikring"
          )
        , ( "65.200"
          , "Gjenforsikring"
          )
        , ( "65.300"
          , "Pensjonskasser"
          )
        , ( "66.110"
          , "Administrasjon av finansmarkeder"
          )
        , ( "66.120"
          , "Verdipapirmegling"
          )
        , ( "66.190"
          , "Andre tjenester tilknyttet finansieringsvirksomhet"
          )
        , ( "66.210"
          , "Risiko- og skadevurdering"
          )
        , ( "66.220"
          , "Forsikringsformidling"
          )
        , ( "66.290"
          , "Andre tjenester tilknyttet forsikringsvirksomhet og pensjonskasser"
          )
        , ( "66.300"
          , "Fondsforvaltningsvirksomhet"
          )
        , ( "68.100"
          , "Kjøp og salg av egen fast eiendom"
          )
        , ( "68.201"
          , "Borettslag"
          )
        , ( "68.209"
          , "Utleie av egen eller leid fast eiendom ellers"
          )
        , ( "68.310"
          , "Eiendomsmegling"
          )
        , ( "68.320"
          , "Eiendomsforvaltning"
          )
        , ( "69.100"
          , "Juridisk tjenesteyting"
          )
        , ( "69.201"
          , "Regnskap og bokføring"
          )
        , ( "69.202"
          , "Revisjon"
          )
        , ( "69.203"
          , "Skatterådgivning"
          )
        , ( "70.100"
          , "Hovedkontortjenester"
          )
        , ( "70.210"
          , "PR og kommunikasjonstjenester"
          )
        , ( "70.220"
          , "Bedriftsrådgivning og annen administrativ rådgivning"
          )
        , ( "71.111"
          , "Plan- og reguleringsarbeid"
          )
        , ( "71.112"
          , "Arkitekttjenester vedrørende byggverk"
          )
        , ( "71.113"
          , "Landskapsarkitekttjenester"
          )
        , ( "71.121"
          , "Byggeteknisk konsulentvirksomhet"
          )
        , ( "71.122"
          , "Geologiske undersøkelser"
          )
        , ( "71.129"
          , "Annen teknisk konsulentvirksomhet"
          )
        , ( "71.200"
          , "Teknisk prøving og analyse"
          )
        , ( "72.110"
          , "Forskning og utviklingsarbeid innen bioteknologi"
          )
        , ( "72.190"
          , "Annen forskning og annet utviklingsarbeid innen naturvitenskap og"
          )
        , ( "72.200"
          , "Forskning og utviklingsarbeid innen samfunnsvitenskap og humanistiske"
          )
        , ( "73.110"
          , "Reklamebyråer"
          )
        , ( "73.120"
          , "Medieformidlingstjenester"
          )
        , ( "73.200"
          , "Markeds- og opinionsundersøkelser"
          )
        , ( "74.101"
          , "Industridesign, produktdesign og annen teknisk designvirksomhet"
          )
        , ( "74.102"
          , "Grafisk og visuell kommunikasjonsdesign"
          )
        , ( "74.103"
          , "Interiørarkitekt, interiørdesign og interiørkonsulentvirksomhet"
          )
        , ( "74.200"
          , "Fotografvirksomhet"
          )
        , ( "74.300"
          , "Oversettelses- og tolkevirksomhet"
          )
        , ( "74.901"
          , "Takseringsvirksomhet"
          )
        , ( "74.902"
          , "Modellbyråvirksomhet"
          )
        , ( "74.903"
          , "Impresariovirksomhet"
          )
        , ( "74.909"
          , "Annen faglig, vitenskapelig og teknisk virksomhet ikke nevnt annet"
          )
        , ( "75.000"
          , "Veterinærtjenester"
          )
        , ( "77.110"
          , "Utleie og leasing av biler og andre lette motorvogner"
          )
        , ( "77.120"
          , "Utleie og leasing av lastebiler"
          )
        , ( "77.210"
          , "Utleie og leasing av sports- og fritidsutstyr"
          )
        , ( "77.220"
          , "Utleie av videofilm, DVD og lignende"
          )
        , ( "77.290"
          , "Utleie og leasing av andre husholdningsvarer og varer til personlig"
          )
        , ( "77.310"
          , "Utleie og leasing av landbruksmaskiner og -utstyr"
          )
        , ( "77.320"
          , "Utleie og leasing av bygge- og anleggsmaskiner og -utstyr"
          )
        , ( "77.330"
          , "Utleie og leasing av kontor- og datamaskiner"
          )
        , ( "77.340"
          , "Utleie og leasing av sjøtransportmateriell"
          )
        , ( "77.350"
          , "Utleie og leasing av lufttransportmateriell"
          )
        , ( "77.390"
          , "Utleie og leasing av andre maskiner og annet utstyr og materiell ikke"
          )
        , ( "77.400"
          , "Leasing av immateriell eiendom og lignende produkter, unntatt"
          )
        , ( "78.100"
          , "Rekruttering og formidling av arbeidskraft"
          )
        , ( "78.200"
          , "Utleie av arbeidskraft"
          )
        , ( "78.300"
          , "Andre personaladministrative tjenester"
          )
        , ( "79.110"
          , "Reisebyråvirksomhet"
          )
        , ( "79.120"
          , "Reisearrangørvirksomhet"
          )
        , ( "79.901"
          , "Turistkontorvirksomhet og destinasjonsselskaper"
          )
        , ( "79.902"
          , "Guider og reiseledere"
          )
        , ( "79.903"
          , "Opplevelses-, arrangements- og aktivitetsarrangørvirksomhet"
          )
        , ( "79.909"
          , "Turistrelaterte tjenester ikke nevnt annet sted"
          )
        , ( "80.100"
          , "Private vakttjenester"
          )
        , ( "80.200"
          , "Tjenester tilknyttet vakttjenester"
          )
        , ( "80.300"
          , "Etterforskning"
          )
        , ( "81.101"
          , "Vaktmestertjenester"
          )
        , ( "81.109"
          , "Andre kombinerte tjenester tilknyttet eiendomsdrift"
          )
        , ( "81.210"
          , "Rengjøring av bygninger"
          )
        , ( "81.220"
          , "Utvendig rengjøring av bygninger og industriell rengjøring"
          )
        , ( "81.291"
          , "Skadedyrkontroll"
          )
        , ( "81.299"
          , "Annen rengjøringsvirksomhet ikke nevnt annet sted"
          )
        , ( "81.300"
          , "Beplantning av hager og parkanlegg"
          )
        , ( "82.110"
          , "Kombinerte kontortjenester"
          )
        , ( "82.190"
          , "Fotokopiering, forberedelse av dokumenter og andre spesialiserte"
          )
        , ( "82.201"
          , "Telefonvakttjenester"
          )
        , ( "82.202"
          , "Telefonsalg"
          )
        , ( "82.300"
          , "Kongress-, messe- og utstillingsvirksomhet"
          )
        , ( "82.910"
          , "Inkasso- og kredittopplysningsvirksomhet"
          )
        , ( "82.920"
          , "Pakkevirksomhet"
          )
        , ( "82.990"
          , "Annen forretningsmessig tjenesteyting ikke nevnt annet sted"
          )
        , ( "84.110"
          , "Generell offentlig administrasjon"
          )
        , ( "84.120"
          , "Offentlig administrasjon tilknyttet helsestell, sosial virksomhet,"
          )
        , ( "84.130"
          , "Offentlig administrasjon tilknyttet næringsvirksomhet og arbeidsmarked"
          )
        , ( "84.210"
          , "Utenrikssaker"
          )
        , ( "84.220"
          , "Forsvar"
          )
        , ( "84.230"
          , "Retts- og fengselsvesen"
          )
        , ( "84.240"
          , "Politi- og påtalemyndighet"
          )
        , ( "84.250"
          , "Brannvern"
          )
        , ( "84.300"
          , "Trygdeordninger underlagt offentlig forvaltning"
          )
        , ( "85.100"
          , "Førskoleundervisning"
          )
        , ( "85.201"
          , "Ordinær grunnskoleundervisning"
          )
        , ( "85.202"
          , "Spesialskoleundervisning for funksjonshemmede"
          )
        , ( "85.203"
          , "Kompetansesentra og annen spesialundervisning"
          )
        , ( "85.310"
          , "Videregående opplæring innen allmennfaglige studieretninger"
          )
        , ( "85.320"
          , "Videregående opplæring innen tekniske og andre yrkesfaglige"
          )
        , ( "85.410"
          , "Undervisning ved fagskoler"
          )
        , ( "85.421"
          , "Undervisning ved universiteter"
          )
        , ( "85.422"
          , "Undervisning ved vitenskapelige høgskoler"
          )
        , ( "85.423"
          , "Undervisning ved statlige høgskoler"
          )
        , ( "85.424"
          , "Undervisning ved militære høgskoler"
          )
        , ( "85.429"
          , "Undervisning ved andre høgskoler"
          )
        , ( "85.510"
          , "Undervisning innen idrett og rekreasjon"
          )
        , ( "85.521"
          , "Kommunal kulturskoleundervisning"
          )
        , ( "85.522"
          , "Undervisning i kunstfag"
          )
        , ( "85.529"
          , "Annen undervisning innen kultur"
          )
        , ( "85.530"
          , "Trafikkskoleundervisning"
          )
        , ( "85.591"
          , "Folkehøgskoleundervisning"
          )
        , ( "85.592"
          , "Arbeidsmarkedskurs"
          )
        , ( "85.593"
          , "Studieforbunds- og frivillige organisasjoners kurs"
          )
        , ( "85.594"
          , "Voksenopplæringssentre"
          )
        , ( "85.595"
          , "Timelærervirksomhet"
          )
        , ( "85.596"
          , "Undervisning innen religion"
          )
        , ( "85.599"
          , "Annen undervisning ikke nevnt annet sted"
          )
        , ( "85.601"
          , "Pedagogisk-psykologisk rådgivningstjeneste"
          )
        , ( "85.609"
          , "Andre tjenester tilknyttet undervisning"
          )
        , ( "86.101"
          , "Alminnelige somatiske sykehus"
          )
        , ( "86.102"
          , "Somatiske spesialsykehus"
          )
        , ( "86.103"
          , "Andre somatiske spesialinstitusjoner"
          )
        , ( "86.104"
          , "Institusjoner i psykisk helsevern for voksne"
          )
        , ( "86.105"
          , "Institusjoner i psykisk helsevern for barn og unge"
          )
        , ( "86.106"
          , "Rusmiddelinstitusjoner"
          )
        , ( "86.107"
          , "Rehabilitering- og opptreningsinstitusjoner"
          )
        , ( "86.211"
          , "Allmenn legetjeneste"
          )
        , ( "86.212"
          , "Somatiske poliklinikker"
          )
        , ( "86.221"
          , "Spesialisert legetjeneste, unntatt psykiatrisk legetjeneste"
          )
        , ( "86.222"
          , "Legetjenester innen psykisk helsevern"
          )
        , ( "86.223"
          , "Poliklinikker i psykisk helsevern for voksne"
          )
        , ( "86.224"
          , "Poliklinikker i psykisk helsevern for barn og unge"
          )
        , ( "86.225"
          , "Rusmiddelpoliklinikker"
          )
        , ( "86.230"
          , "Tannhelsetjenester"
          )
        , ( "86.901"
          , "Hjemmesykepleie"
          )
        , ( "86.902"
          , "Fysioterapitjeneste"
          )
        , ( "86.903"
          , "Helsestasjon og skolehelsetjeneste"
          )
        , ( "86.904"
          , "Annen forebyggende helsetjeneste"
          )
        , ( "86.905"
          , "Klinisk psykologtjeneste"
          )
        , ( "86.906"
          , "Medisinske laboratorietjenester"
          )
        , ( "86.907"
          , "Ambulansetjenester"
          )
        , ( "86.909"
          , "Andre helsetjenester"
          )
        , ( "87.101"
          , "Somatiske spesialsykehjem"
          )
        , ( "87.102"
          , "Somatiske sykehjem"
          )
        , ( "87.201"
          , "Psykiatriske sykehjem"
          )
        , ( "87.202"
          , "Omsorgsinstitusjoner for rusmiddelmisbrukere"
          )
        , ( "87.203"
          , "Bofellesskap for psykisk utviklingshemmede"
          )
        , ( "87.301"
          , "Aldershjem"
          )
        , ( "87.302"
          , "Bofellesskap for eldre og funksjonshemmede med fast tilknyttet"
          )
        , ( "87.303"
          , "Bofellesskap for eldre og funksjonshemmede med fast tilknyttet"
          )
        , ( "87.304"
          , "Avlastningsboliger/-institusjoner"
          )
        , ( "87.305"
          , "Barneboliger"
          )
        , ( "87.901"
          , "Institusjoner innen barne- og ungdomsvern"
          )
        , ( "87.909"
          , "Omsorgsinstitusjoner ellers"
          )
        , ( "88.101"
          , "Hjemmehjelp"
          )
        , ( "88.102"
          , "Dagsentra/aktivitetssentra for eldre og funksjonshemmede"
          )
        , ( "88.103"
          , "Eldresentre"
          )
        , ( "88.911"
          , "Barnehager"
          )
        , ( "88.912"
          , "Barneparker og dagmammaer"
          )
        , ( "88.913"
          , "Skolefritidsordninger"
          )
        , ( "88.914"
          , "Fritidsklubber for barn og ungdom"
          )
        , ( "88.991"
          , "Barneverntjenester"
          )
        , ( "88.992"
          , "Familieverntjenester"
          )
        , ( "88.993"
          , "Arbeidstrening for ordinært arbeidsmarked"
          )
        , ( "88.994"
          , "Varig tilrettelagt arbeid"
          )
        , ( "88.995"
          , "Sosiale velferdsorganisasjoner"
          )
        , ( "88.996"
          , "Asylmottak"
          )
        , ( "88.997"
          , "Sosialtjenester for rusmiddelmisbrukere uten botilbud"
          )
        , ( "88.998"
          , "Kommunale sosialkontortjenester"
          )
        , ( "88.999"
          , "Andre sosialtjenester uten botilbud"
          )
        , ( "90.011"
          , "Utøvende kunstnere og underholdningsvirksomhet innen musikk"
          )
        , ( "90.012"
          , "Utøvende kunstnere og underholdningsvirksomhet innen scenekunst"
          )
        , ( "90.019"
          , "Utøvende kunstnere og underholdningsvirksomhet ikke nevnt annet sted"
          )
        , ( "90.020"
          , "Tjenester tilknyttet underholdningsvirksomhet"
          )
        , ( "90.031"
          , "Selvstendig kunstnerisk virksomhet innen visuell kunst"
          )
        , ( "90.032"
          , "Selvstendig kunstnerisk virksomhet innen musikk"
          )
        , ( "90.033"
          , "Selvstendig kunstnerisk virksomhet innen scenekunst"
          )
        , ( "90.034"
          , "Selvstendig kunstnerisk virksomhet innen litteratur"
          )
        , ( "90.039"
          , "Selvstendig kunstnerisk virksomhet ikke nevnt annet sted"
          )
        , ( "90.040"
          , "Drift av lokaler tilknyttet kunstnerisk virksomhet"
          )
        , ( "91.011"
          , "Drift av folkebiblioteker"
          )
        , ( "91.012"
          , "Drift av fag- og forskningsbiblioteker"
          )
        , ( "91.013"
          , "Drift av arkiver"
          )
        , ( "91.021"
          , "Drift av kunst- og kunstindustrimuseer"
          )
        , ( "91.022"
          , "Drift av kulturhistoriske museer"
          )
        , ( "91.023"
          , "Drift av naturhistoriske museer"
          )
        , ( "91.029"
          , "Drift av museer ikke nevnt annet sted"
          )
        , ( "91.030"
          , "Drift av historiske steder og bygninger og lignende severdigheter"
          )
        , ( "91.040"
          , "Drift av botaniske og zoologiske hager og naturreservater"
          )
        , ( "92.000"
          , "Lotteri og totalisatorspill"
          )
        , ( "93.110"
          , "Drift av idrettsanlegg"
          )
        , ( "93.120"
          , "Idrettslag og -klubber"
          )
        , ( "93.130"
          , "Treningssentre"
          )
        , ( "93.190"
          , "Andre sportsaktiviteter"
          )
        , ( "93.210"
          , "Drift av fornøyelses- og temaparker"
          )
        , ( "93.291"
          , "Opplevelsesaktiviteter"
          )
        , ( "93.292"
          , "Fritidsetablissement"
          )
        , ( "93.299"
          , "Fritidsvirksomhet ellers"
          )
        , ( "94.110"
          , "Næringslivs- og arbeidsgiverorganisasjoner"
          )
        , ( "94.120"
          , "Yrkessammenslutninger"
          )
        , ( "94.200"
          , "Arbeidstakerorganisasjoner"
          )
        , ( "94.910"
          , "Religiøse organisasjoner"
          )
        , ( "94.920"
          , "Partipolitiske organisasjoner"
          )
        , ( "94.991"
          , "Aktiviteter i andre interesseorganisasjoner ikke nevnt annet sted"
          )
        , ( "94.992"
          , "Fond/legater som støtter veldedige og allmennyttige formål"
          )
        , ( "95.110"
          , "Reparasjon av datamaskiner og tilleggsutstyr"
          )
        , ( "95.120"
          , "Reparasjon av kommunikasjonsutstyr"
          )
        , ( "95.210"
          , "Reparasjon av elektronikk til husholdningsbruk"
          )
        , ( "95.220"
          , "Reparasjon av husholdningsvarer og hageredskaper"
          )
        , ( "95.230"
          , "Reparasjon av skotøy og lærvarer"
          )
        , ( "95.240"
          , "Reparasjon av møbler og boliginnredning"
          )
        , ( "95.250"
          , "Reparasjon av ur, gull- og sølvvarer"
          )
        , ( "95.290"
          , "Reparasjon av andre husholdningsvarer og varer til personlig bruk"
          )
        , ( "96.010"
          , "Vaskeri- og renserivirksomhet"
          )
        , ( "96.020"
          , "Frisering og annen skjønnhetspleie"
          )
        , ( "96.030"
          , "Begravelsesbyråvirksomhet og drift av kirkegårder og krematorier"
          )
        , ( "96.040"
          , "Virksomhet knyttet til kroppspleie og fysisk velvære"
          )
        , ( "96.090"
          , "Personlig tjenesteyting ikke nevnt annet sted"
          )
        , ( "97.000"
          , "Lønnet arbeid i private husholdninger"
          )
        , ( "99.000"
          , "Internasjonale organisasjoner og organer"
          )
        , ( "01.250"
          , "Dyrking av annen frukt som vokser på trær eller busker samt nøtter"
          )
        , ( "01.620"
          , "Tjenester tilknyttet husdyrhold"
          )
        , ( "55.300"
          , "Drift av campingplasser"
          )
        , ( "64.306"
          , "Aktive eierfond"
          )
        , ( "64.308"
          , "Investeringsselskaper og lignende lukket for allmennheten"
          )
        , ( "43.221"
          , "Rørleggerarbeid"
          )
        , ( "43.222"
          , "Kuldeanlegg- og varmepumpearbeid"
          )
        , ( "52.216"
          , "Kondensering av gass med henblikk på transport"
          )
        , ( "64.910"
          , "Finansiell leasing"
          )
        , ( "43.223"
          , "Ventilasjonsarbeid"
          )
        , ( "71.123"
          , "Kart og oppmåling"
          )
        , ( "90.035"
          , "Selvstendig kunstnerisk virksomhet innen blogging"
          )
        ]
