const MICRO_ADRESS_LENGTH = 8;

const CONTROL_SIGNALS = {
    "next":new BitsDatatype(MICRO_ADRESS_LENGTH),
    "c":BitDatatype.STATIC,
    "s":BitDatatype.STATIC,
    "info":FreeDatatype.STATIC,
    "mbrIn":BitDatatype.STATIC,
    "mbrOut":BitDatatype.STATIC,
    "marIn":BitDatatype.STATIC,
    "memRead":BitDatatype.STATIC,
    "memWrite":BitDatatype.STATIC,
    "aIn":BitDatatype.STATIC,
    "aOut":BitDatatype.STATIC,
    "oToA":BitDatatype.STATIC,
    "aToZ":BitDatatype.STATIC,
    "irIn":BitDatatype.STATIC,
    "irOut":BitDatatype.STATIC,
    "pcIn":BitDatatype.STATIC,
    "pcOut":BitDatatype.STATIC,
    "pcInc":BitDatatype.STATIC,
    "swrOut":BitDatatype.STATIC,
    "outIn":BitDatatype.STATIC,
    "carryIn":BitDatatype.STATIC,
    "aluOp":AluSimple.OPERATION_DATATYPE
}

// CONSTROL_STATES[] = BUILD_STATE({"info":"","next":ADR(2)});


const CONSTROL_STATES = [];
CONSTROL_STATES[0] = BUILD_STATE({"info":"Fetch0","next":ADR(1),"pcOut":true, "marIn":true});// pc -> mar
CONSTROL_STATES[1] = BUILD_STATE({"info":"Fetch1","next":ADR(2), "memRead":true,"pcInc":true});// pc++, mem[mar] -> mbr
CONSTROL_STATES[2] = BUILD_STATE({"info":"Fetch2","next":ADR(3), "mbrOut":true, "irIn":true});// mbr -> ir
CONSTROL_STATES[3] = BUILD_STATE({"info":"Fetch3 (Op decode)","next":ADR(4),"c":true});// branch
CONSTROL_STATES[4+0b0000] = BUILD_STATE({"info":"hlt","next":ADR(4)});//TODO
CONSTROL_STATES[4+0b0001] = BUILD_STATE({"info":"jma","next":ADR(255)});//TODO
CONSTROL_STATES[4+0b0010] = BUILD_STATE({"info":"jmp","next":ADR(255)});//TODO
CONSTROL_STATES[4+0b0011] = BUILD_STATE({"info":"jsr","next":ADR(255)});//TODO
CONSTROL_STATES[4+0b0100] = BUILD_STATE({"info":"swr","next":ADR(255)});//TODO
CONSTROL_STATES[4+0b0101] = BUILD_STATE({"info":"ral","next":ADR(255)});//TODO
CONSTROL_STATES[4+0b0110] = BUILD_STATE({"info":"inp","next":ADR(255)});//TODO
CONSTROL_STATES[4+0b0111] = BUILD_STATE({"info":"out","next":ADR(255)});//TODO
CONSTROL_STATES[4+0b1000] = BUILD_STATE({"info":"not","next":ADR(255)});//TODO
CONSTROL_STATES[4+0b1001] = BUILD_STATE({"info":"lda1","next":ADR(20),"irOut":true,"marIn":true});// ir -> mar
CONSTROL_STATES[4+0b1010] = BUILD_STATE({"info":"sta1","next":ADR(22),"irOut":true,"marIn":true});//ir -> mar
CONSTROL_STATES[4+0b1011] = BUILD_STATE({"info":"add1","next":ADR(24),"irOut":true,"marIn":true});//ir -> mar
CONSTROL_STATES[4+0b1100] = BUILD_STATE({"info":"xor","next":ADR(255)});//TODO
CONSTROL_STATES[4+0b1101] = BUILD_STATE({"info":"and","next":ADR(255)});//TODO
CONSTROL_STATES[4+0b1110] = BUILD_STATE({"info":"ior","next":ADR(255)});//TODO
CONSTROL_STATES[4+0b1111] = BUILD_STATE({"info":"nop","next":ADR(255)});//TODO

CONSTROL_STATES[20] = BUILD_STATE({"info":"lda2","next":ADR(21),"memRead":true});//  mem[mar] -> mbr
CONSTROL_STATES[21] = BUILD_STATE({"info":"lda3","next":ADR(0),"mbrOut":true,"aIn":true});// mbr -> a

CONSTROL_STATES[22] = BUILD_STATE({"info":"sta2","next":ADR(23),"aOut":true,"mbrIn":true});// a -> mbr
CONSTROL_STATES[23] = BUILD_STATE({"info":"sta3","next":ADR(0),"memWrite":true});// mbr -> mem[mar]

CONSTROL_STATES[24] = BUILD_STATE({"info":"add2","next":ADR(25),"aToZ":true,"memRead":true});// a -> z, mem[mar] -> mbr
CONSTROL_STATES[25] = BUILD_STATE({"info":"add3","next":ADR(0),"mbrOut":true,"aluOp":"x+y","oToA":true});// mbr+z -> a


CONSTROL_STATES[255] = BUILD_STATE({"info":"TODO ...","next":ADR(255),"pcInc":true});

function ADR(x) {
    let ret = [];
    for (let i = 0; i < MICRO_ADRESS_LENGTH; i++) ret.push(((x >> i) & 1) === 1);
    return ret;
}

//alle nicht angegebenen daten werden auf den Standardtyp gesetzt.
function BUILD_STATE(data) {
    let ret = {};
    let kys = Object.keys(CONTROL_SIGNALS);
    for (let k of kys) {
        let v = data[k];
        if (v === undefined) v = CONTROL_SIGNALS[k].getDefaultValue();
        ret[k] = v;
    }
    return ret;
}
