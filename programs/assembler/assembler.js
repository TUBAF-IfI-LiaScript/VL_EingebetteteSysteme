const OPCODES = [
    "HLT",//0000
    "JMA",//0001
    "JMP",//0010
    "JSR",//0011
    "SWR",//0100
    "RAR",//0101
    "INP",//0110
    "OUT",//0111
    "NOT",//1000
    "LDA",//1001
    "STA",//1010
    "ADD",//1011
    "XOR",//1100
    "AND",//1101
    "IOR",//1110
    "NOP" //1111
];
function assembleStep1(str) {
    let strLines = str.split("\n");
    let lines = [];
    for (let l of strLines) {
        let wordsStr = l.split(" ");
        let words = [];
        for (let word of wordsStr) {
            if (word !== "") words.push(word);
        }
        if (words.length > 0) lines.push(words);
    }
    console.log(lines);
    let mkrData = _extractMakrosAndRemoveComments(lines);
    lines = mkrData.lines;
    let makros = mkrData.makros;
    console.log(lines,makros);
    for (let i = 0; i < 10; i++) {
        let apmData = _assembleApplyMakrosStep(lines,makros);
        if (!apmData.changed) break;
        lines = apmData.lines;
    }
    console.log(lines);
    return lines;
}

function assembleStep2(lines) {
    return _assebleLabels(lines);
}
function assembleStep3(lines) {
    return _assembleFinish(lines);
}

function assemble(str) {
    return assembleStep3(assembleStep2(assembleStep1(str)));
}

function _extractMakrosAndRemoveComments(lines) {
    let linesNew = [];
    let makros = {};
    let isInMakro = false;
    let currenMakroName, currenMakroParameterNames, currenMarkoLines;
    for (let l of lines) {
        if (l[0] === "@define") {
            if (isInMakro) throw new Error("can't define makros in makros!");
            if (l.length < 2) throw new Error("missing makro name after @define");
            currenMakroName = l[1];
            currenMakroParameterNames = [];
            for (let i = 2; i < l.length; i++) currenMakroParameterNames.push(l[i]);
            isInMakro = true;
            currenMarkoLines = [];
        } else if (l[0] === "@end") {
            if (!isInMakro) throw new Error("can't use @end outside of makros bla bla");
            makros[currenMakroName] = new Makro(currenMakroName,currenMakroParameterNames,currenMarkoLines);
            isInMakro = false;
        } else if (l[0] === "@") {
            //do nothing (comment)
        } else if (isInMakro) {
            currenMarkoLines.push(l);
        } else {
            linesNew.push(l);
        }
    }
    return {"lines":linesNew,"makros":makros};
}

function _assembleApplyMakrosStep(lines,makros) {
    let ret = [];
    let changed = false;
    for (let l of lines) {
        if (l[0].startsWith("@")) {
            let makroName = l[0].substring(1,l[0].length);
            if (makros[makroName] !== undefined) {
                let mLines = makros[makroName].apply(l.slice(1));
                console.log("mLines:",mLines);
                for (let ml of mLines) ret.push(ml);
                changed = true;
            } else {
                ret.push(l);
            }
        } else {
            ret.push(l);
        }
    }
    return {"changed":changed,"lines":ret};
}

function _assebleLabels(lines) {
    let labels = {};
    let lines2 = [];
    let i = 0;
    for (let l of lines) {
        if (l[0].endsWith(":")) {
            let labelName = l[0].substring(0,l[0].length-1);
            let labelInt = Math.floor(labelName*1);
            if (isNaN(labelInt)) {
                labels[labelName] = i;
            } else {
                i = labelInt;
            }
            if (l.length > 1) {
                lines2[i++] = l.slice(1);
            }
        } else {
            lines2[i++] = l;
        }
    }
    let linesNew = [];
    for (let i = 0; i < lines2.length; i++) {
        let l = lines2[i];
        if (l === undefined) l = [0];
        let ln = [];
        for (let w of l) {
            if (labels[w] !== undefined) {
                ln.push(labels[w]);
            } else {
                ln.push(w);
            }
        }
        linesNew.push(ln);
    }
    return linesNew;
}
function _assembleFinish(lines) {
    let ret = [];
    for (let l of lines) {
        let w0 = (l[0]+"").toUpperCase();
        let i = OPCODES.indexOf(w0);
        if (i === -1) {
            if (isNaN(l[0]*1)) throw new Error("unknown word " + l[0]);
            ret.push(l[0]*1 & 0xffff);
        } else if (l.length > 1) {
            if (isNaN(l[1]*1)) throw new Error("unknown word " + l[1]);
            ret.push((i << 12) | (l[1] & 0x0fff));
        } else {
            ret.push(i << 12);
        }
    }
    return ret;
}
class Makro {
    constructor(name,parameterNames,lines) {
        this.name = name;
        this.parameterNames = parameterNames;
        this.lines = lines;
        this.labels = [];
        for (let l of this.lines) if (l[0].endsWith(":")) this.labels.push(l[0].substring(0,l[0].length-1));
        this.useCount = 0;
    }
    apply(parameterValues) {
        if (this.parameterNames.length !== parameterValues.length) throw new Error("wrong parameter length in makro call " + this.name);
        let ret = [];
        for (let l of this.lines) {
            let lNew = [];
            for (let w of l) {
                let i = -1;
                if (w.startsWith("@")) i = this.parameterNames.indexOf(w.substring(1,w.length));
                if (i !== -1) {
                    lNew.push(parameterValues[i]);
                } else {
                    let i = this.labels.indexOf(w);
                    if (i !== -1) {
                        lNew.push(this.name + "_" + this.labels[i] + "_" + this.useCount);
                    } else {
                        if (i === -1 && w.endsWith(":")) i = this.labels.indexOf(w.substring(0,w.length-1));
                        if (i !== -1) {
                            lNew.push(this.name + "_" + this.labels[i] + "_" + this.useCount + ":");
                        } else {
                            lNew.push(w);
                        }
                    }
                }
            }
            ret.push(lNew);
        }
        this.useCount++;
        return ret;
    }
    
}
