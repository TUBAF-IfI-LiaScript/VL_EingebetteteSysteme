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
AluSimple.OPERATION_DATATYPE = new ElementOfSetDatatype(["x+y","~x","x and y","x or y","rar(x)"],"AluOp");

function xor(a,b) {
    return a && !b || !a && b;
}
