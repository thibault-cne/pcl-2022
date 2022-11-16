package ast;

public class Affect implements Ast{

    public <T> T accept(AstVisitor<T> visitor){
        return visitor.visit(this);
    }

    public Ast idf;
    public Ast expression;

    public Affect(Ast idf, Ast expr){
        this.idf = idf;
        this.expression = expr;
    }

}
