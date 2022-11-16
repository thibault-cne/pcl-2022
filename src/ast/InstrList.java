package ast;

import java.util.ArrayList;

public class InstrList implements Ast {
    
    // Utile pour la dernière partie
    public <T> T accept(AstVisitor<T> visitor){
        return visitor.visit(this);
    }
    
    public ArrayList<Ast> instrList;

    public InstrList() {
        this.instrList = new ArrayList<>();
    }

    public void addInstr(Ast instr){
        this.instrList.add(instr);
    }

}
