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
