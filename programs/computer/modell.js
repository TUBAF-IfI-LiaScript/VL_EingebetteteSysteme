class Register extends FjangComponent {
    constructor(datatype) {
        super();
        this.busNode = new FjangNode(datatype);
        this.valueNode = new FjangNode(datatype);
        this.outputEnableNode = new FjangNode(BitDatatype.STATIC);
        this.inputEnableNode = new FjangNode(BitDatatype.STATIC);
        this.clockNode = new FjangNode(BitDatatype.STATIC);
        this.oldClockState = false;
    }
    getNodes() {
        return [this.busNode,this.valueNode,this.outputEnableNode,this.inputEnableNode,this.clockNode];
    }
    tick() {
        if (!this.oldClockState && this.clockNode.get() && this.inputEnableNode.get()) this.valueNode.set(this.busNode.get());
        if (this.outputEnableNode.get()) this.busNode.set(this.valueNode.get());
        this.oldClockState = this.clockNode.get();
    }
}
class BusPlusExtraInputRegister extends FjangComponent {
    constructor(datatype) {
        super();
        this.busNode = new FjangNode(datatype);
        this.secondInputNode = new FjangNode(datatype);
        this.valueNode = new FjangNode(datatype);
        this.outputEnableNode = new FjangNode(BitDatatype.STATIC);
        this.inputEnableBusNode = new FjangNode(BitDatatype.STATIC);
        this.inputEnableSecondNode = new FjangNode(BitDatatype.STATIC);
        this.clockNode = new FjangNode(BitDatatype.STATIC);
        this.oldClockState = false;
    }
    getNodes() {
        return [this.busNode,this.secondInputNode,this.valueNode,this.outputEnableNode,this.inputEnableBusNode,this.inputEnableSecondNode,this.clockNode];
    }
    tick() {
        if (!this.oldClockState && this.clockNode.get()) {
            if (this.inputEnableBusNode.get()) this.valueNode.set(this.busNode.get());
            if (this.inputEnableSecondNode.get()) this.valueNode.set(this.secondInputNode.get());
        }
        
        if (this.outputEnableNode.get()) this.busNode.set(this.valueNode.get());
        
        this.oldClockState = this.clockNode.get();
    }
}
class ARegister extends FjangComponent {
    constructor(bitsLength) {
        super();
        this.bitsLength = bitsLength;
        this.bdt = new BitsDatatype(bitsLength);
        this.busNode = new FjangNode(this.bdt);
        this.secondInputNode = new FjangNode(this.bdt);
        this.valueNode = new FjangNode(this.bdt);
        this.signumNode = new FjangNode(BitDatatype.STATIC);
        this.outputEnableNode = new FjangNode(BitDatatype.STATIC);
        this.inputEnableBusNode = new FjangNode(BitDatatype.STATIC);
        this.inputEnableSecondNode = new FjangNode(BitDatatype.STATIC);
        this.clockNode = new FjangNode(BitDatatype.STATIC);
        this.oldClockState = false;
    }
    getNodes() {
        return [this.busNode,this.secondInputNode,this.valueNode,this.signumNode,this.outputEnableNode,this.inputEnableBusNode,this.inputEnableSecondNode,this.clockNode];
    }
    tick() {
        if (!this.oldClockState && this.clockNode.get()) {
            if (this.inputEnableBusNode.get()) this.valueNode.set(this.busNode.get());
            if (this.inputEnableSecondNode.get()) this.valueNode.set(this.secondInputNode.get());
        }
        
        if (this.outputEnableNode.get()) this.busNode.set(this.valueNode.get());
        
        this.signumNode.set(this.valueNode.get()[this.bitsLength-1]);
        this.oldClockState = this.clockNode.get();
    }
}

class MemoryAdressRegister extends FjangComponent {
    // busLength >= adressLength
    constructor(busLength, adressLength) {
        super();
        this.busNode = new FjangNode(new BitsDatatype(busLength));
        this.valueNode = new FjangNode(new BitsDatatype(adressLength));
        this.inputEnableNode = new FjangNode(BitDatatype.STATIC);
        this.clockNode = new FjangNode(BitDatatype.STATIC);
        this.oldClockState = false;
        this.busLength = busLength;
        this.adressLength = adressLength;
    }
    getNodes() {
        return [this.busNode,this.valueNode,this.inputEnableNode,this.clockNode];
    }
    tick() {
        if (!this.oldClockState && this.clockNode.get() && this.inputEnableNode.get()) {
            this.valueNode.set(this.busNode.get().slice(0,this.adressLength));
        }
        this.oldClockState = this.clockNode.get();
    }
}

class ProgramCounterRegister extends FjangComponent {
    constructor(bitsLength) {
        super();
        this.bitsLength = bitsLength;
        let bdt = new BitsDatatype(bitsLength);
        this.busNode = new FjangNode(bdt);
        this.valueNode = new FjangNode(bdt);
        this.outputEnableNode = new FjangNode(BitDatatype.STATIC);
        this.inputEnableNode = new FjangNode(BitDatatype.STATIC);
        this.clockNode = new FjangNode(BitDatatype.STATIC);
        this.countNode = new FjangNode(BitDatatype.STATIC);
        this.oldClockState = false;
    }
    getNodes() {
        return [this.busNode,this.valueNode,this.outputEnableNode,this.inputEnableNode,this.clockNode,this.countNode];
    }
    tick() {
        if (!this.oldClockState && this.clockNode.get()) {
             if (this.inputEnableNode.get()) this.valueNode.set(this.busNode.get());
            if (this.countNode.get()) this.countUp();
        }
        if (this.outputEnableNode.get()) this.busNode.set(this.valueNode.get());
        this.oldClockState = this.clockNode.get();
    }
    countUp() {
        let v = this.valueNode.get();
        let vInc = [];
        let carry = true;
        for (let i = 0; i < this.bitsLength; i++) {
            vInc.push(xor(v[i],carry));
            carry = carry && v[i];
        }
        this.valueNode.set(vInc);
    }
}

class InstructionRegister extends FjangComponent {
    // busLength >= opcodeLength
    constructor(busLength, opcodeLength) {
        super();
        this.busNode = new FjangNode(new BitsDatatype(busLength));
        this.valueNode = new FjangNode(new BitsDatatype(busLength));
        this.opcodeNode = new FjangNode(new BitsDatatype(opcodeLength));
        this.inputEnableNode = new FjangNode(BitDatatype.STATIC);
        this.outputEnableNode = new FjangNode(BitDatatype.STATIC);
        this.clockNode = new FjangNode(BitDatatype.STATIC);
        this.oldClockState = false;
        this.busLength = busLength;
        this.opcodeLength = opcodeLength;
    }
    getNodes() {
        return [this.busNode,this.valueNode,this.opcodeNode,this.inputEnableNode,this.outputEnableNode,this.clockNode];
    }
    tick() {
        if (!this.oldClockState && this.clockNode.get() && this.inputEnableNode.get()) {
            let v = this.busNode.get();
            this.valueNode.set(v);
            this.opcodeNode.set(v.slice(this.busLength-this.opcodeLength,this.busLength));
        }
        if (this.outputEnableNode.get()) this.busNode.set(this.valueNode.get());
        this.oldClockState = this.clockNode.get();
    }
}

class Memory extends FjangComponent {
    constructor(datatype, adrLength, words) {
        super();
        this.adrDataType = new BitsDatatype(adrLength);
        this.adrLength = adrLength;
        this.dataInNode = new FjangNode(datatype);
        this.dataOutNode = new FjangNode(datatype);
        this.adressNode = new FjangNode(this.adrDataType);
        this.writeEnableNode = new FjangNode(BitDatatype.STATIC);
        this.clockNode = new FjangNode(BitDatatype.STATIC);
        this.oldClockState = false;
        this.words = words;
    }
    getNodes() {
        return [this.dataInNode,this.dataOutNode,this.adressNode,this.writeEnableNode,this.clockNode];
    }
    tick() {
        let a = this.adrDataType.toUInt(this.adressNode.get());
        this.dataOutNode.set(this.words[a]);
        if (!this.oldClockState && this.clockNode.get() && this.writeEnableNode.get()) this.words[a] = this.dataInNode.get();
        this.oldClockState = this.clockNode.get();
    }
}

class AluSimple extends FjangComponent {
    constructor(bitsLength) {
        super();
        let bdt = new BitsDatatype(bitsLength);
        this.bitsLength = bitsLength;
        this.xNode = new FjangNode(bdt);
        this.yNode = new FjangNode(bdt);
        this.outNode = new FjangNode(bdt);
        this.opNode = new FjangNode(AluSimple.OPERATION_DATATYPE);
        this.carryInNode = new FjangNode(BitDatatype.STATIC);
        this.carryOutNode = new FjangNode(BitDatatype.STATIC);
        this.overflowNode = new FjangNode(BitDatatype.STATIC);
    }
    getNodes() {
        return [this.xNode,this.yNode,this.outNode,this.opNode,this.carryInNode,this.carryOutNode,this.overflowNode];
    }
    tick() {
        let op = this.opNode.get();
        let x = this.xNode.get();
        let y = this.yNode.get();
        let carryIn = this.carryInNode.get();
        let out = undefined;
        let carryOut = false;
        let overflow = false;
        switch(op) {
            case "x+y":
                let carr = carryIn;
                out = [];
                for (let i = 0; i < this.bitsLength; i++) {
                    out.push(xor(xor(x[i],y[i]),carr));
                    let newCarry = x[i] && y[i] || x[i] && carr || y[i] && carr
                    if (i === this.bitsLength-1) {
                        overflow = xor(newCarry,carr);
                    }
                    carr = newCarry;
                }
                carryOut = carr;
                break;
            case "~x":
                out = [];
                for (let i = 0; i < this.bitsLength; i++) out.push(!x[i]);
                break;
            case "x and y":
                out = [];
                for (let i = 0; i < this.bitsLength; i++) out.push(x[i] && y[i]);
                break;
            case "x or y":
                out = [];
                for (let i = 0; i < this.bitsLength; i++) out.push(x[i] || y[i]);
                break;
            case "x xor y":
                out = [];
                for (let i = 0; i < this.bitsLength; i++) out.push(xor(x[i],y[i]));
                break;
            case "rar(x)":
                out = [];
                for (let i = 0; i < this.bitsLength; i++) out.push(x[(i+1)%this.bitsLength]);
                break;
            default:
                out = [];
                for (let i = 0; i < this.bitsLength; o++) out.push(false);
        }
        this.outNode.set(out);
        this.carryOutNode.set(carryOut);
        this.overflowNode.set(overflow);
    }
}
AluSimple.OPERATION_DATATYPE = new ElementOfSetDatatype(["x+y","~x","x and y","x or y","x xor y","rar(x)"],"AluOp");

function xor(a,b) {
    return a && !b || !a && b;
}

class OpcodeInterpreter extends FjangComponent {
    constructor(opcodeSize,opcodes) {
        super();
        this.bdt = new BitsDatatype(opcodeSize);
        this.opcodeSize = opcodeSize;
        this.opcodes = opcodes;
        this.opcodeBitsInputNode = new FjangNode(this.bdt);
        this.opcodeOutputNode = new FjangNode(new ElementOfSetDatatype(opcodes));
    }
    getNodes() {
        return [this.opcodeBitsInputNode,this.opcodeOutputNode];
    }
    tick() {
        this.opcodeOutputNode.set(this.opcodes[this.bdt.toUInt(this.opcodeBitsInputNode.get())]);
    }
}

class BusOutBuffer extends FjangComponent {
    constructor(datatype) {
        super();
        this.datatype = datatype;
        this.busNode = new FjangNode(datatype);
        this.inputNode = new FjangNode(datatype);
        this.outputEnableNode = new FjangNode(BitDatatype.STATIC);
    }
    getNodes() {
        return [this.busNode,this.inputNode,this.outputEnableNode];
    }
    tick() {
        if (this.outputEnableNode.get()) this.busNode.set(this.inputNode.get());
    }
}

class AdressMagic extends FjangComponent {
    constructor(miroAdressLength, opcodeLength) {
        super();
        this.miroAdressLength = miroAdressLength;
        this.opcodeLength = opcodeLength;
        let bdtA = new BitsDatatype(miroAdressLength);
        this.adressInNode = new FjangNode(bdtA);
        this.adressOutNode = new FjangNode(bdtA);
        this.opcodeNode = new FjangNode(new BitsDatatype(opcodeLength));
        this.negativeNode = new FjangNode(BitDatatype.STATIC);
        this.cNode = new FjangNode(BitDatatype.STATIC);
        this.sNode = new FjangNode(BitDatatype.STATIC);
    }
    getNodes() {
        return [this.adressInNode,this.adressOutNode,this.opcodeNode,this.negativeNode,this.cNode,this.sNode];
    }
    tick() {
        let c = this.cNode.get();
        let s = this.sNode.get();
        let neg = this.negativeNode.get();
        let adrIn = this.adressInNode.get();
        let opcode = this.opcodeNode.get();
        let adrOut = adrIn;
        if (c) {
            adrOut = BitsDatatype.sum(adrIn,opcode,false);
        } else if (s && !neg) {
            adrOut = BitsDatatype.increment(adrIn);
        }
        this.adressOutNode.set(adrOut);
    }
}

class ControlBoss extends FjangComponent {
//  constollSignals: {"signalname":datatype,"signalname2":datatype2,...}
//  states:         [{"signalname":value,...},...]
    constructor(controllSignals,states,microAdressLength) {
        super();
        this.microAdressBitsDatatype = new BitsDatatype(microAdressLength)
        this.microAdressLength = microAdressLength;
        this.controllSignals = controllSignals;
        this.states = states;
        this.currentStateIndex = 0;
        this.adressInNode = new FjangNode(this.microAdressBitsDatatype);
        this.signalNames = Object.keys(controllSignals);
        this.signalNodes = {};
        for (let n of this.signalNames) this.signalNodes[n] = new FjangNode(controllSignals[n]);
    }
    getNodes() {
        let ret = [this.adressInNode];
        for (let n of this.signalNames) ret.push(this.signalNodes[n]);
        return ret;
    }
    tick() {
        this.currentStateIndex = this.microAdressBitsDatatype.toUInt(this.adressInNode.get());
        let currentState = this.states[this.currentStateIndex];
        for (let n of this.signalNames) this.signalNodes[n].set(currentState[n]);
    }
}

class AutoClock extends FjangComponent {
    constructor(oscillationPeriod) {
        super();
        this.oscillationPeriod = oscillationPeriod;
        this.time = 1;
        this.enableNode = new FjangNode(BitDatatype.STATIC);
        this.clockNode = new FjangNode(BitDatatype.STATIC);
    }
    getNodes() {
        return [this.enableNode,this.clockNode];
    }
    tick() {
        if (this.enableNode.get()) {
            this.clockNode.set(this.time === 0);
            this.time = (this.time+1)%this.oscillationPeriod;
        }
    }
}
