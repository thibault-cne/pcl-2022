// Generated from ./expr.g4 by ANTLR 4.9.2

package parser;

import org.antlr.v4.runtime.tree.ParseTreeVisitor;

/**
 * This interface defines a complete generic visitor for a parse tree produced
 * by {@link exprParser}.
 *
 * @param <T> The return type of the visit operation. Use {@link Void} for
 * operations with no return type.
 */
public interface exprVisitor<T> extends ParseTreeVisitor<T> {
	/**
	 * Visit a parse tree produced by {@link exprParser#program}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitProgram(exprParser.ProgramContext ctx);
	/**
	 * Visit a parse tree produced by {@link exprParser#instr}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitInstr(exprParser.InstrContext ctx);
	/**
	 * Visit a parse tree produced by {@link exprParser#print_litteral}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitPrint_litteral(exprParser.Print_litteralContext ctx);
	/**
	 * Visit a parse tree produced by the {@code IfThenElse}
	 * labeled alternative in {@link exprParser#if_litteral}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitIfThenElse(exprParser.IfThenElseContext ctx);
	/**
	 * Visit a parse tree produced by the {@code IfThen}
	 * labeled alternative in {@link exprParser#if_litteral}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitIfThen(exprParser.IfThenContext ctx);
	/**
	 * Visit a parse tree produced by {@link exprParser#instr_list}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitInstr_list(exprParser.Instr_listContext ctx);
	/**
	 * Visit a parse tree produced by {@link exprParser#affect}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitAffect(exprParser.AffectContext ctx);
	/**
	 * Visit a parse tree produced by {@link exprParser#expr}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitExpr(exprParser.ExprContext ctx);
	/**
	 * Visit a parse tree produced by {@link exprParser#plus}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitPlus(exprParser.PlusContext ctx);
	/**
	 * Visit a parse tree produced by {@link exprParser#mult}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitMult(exprParser.MultContext ctx);
	/**
	 * Visit a parse tree produced by the {@code Integer}
	 * labeled alternative in {@link exprParser#value}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitInteger(exprParser.IntegerContext ctx);
	/**
	 * Visit a parse tree produced by the {@code Identifier}
	 * labeled alternative in {@link exprParser#value}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitIdentifier(exprParser.IdentifierContext ctx);
	/**
	 * Visit a parse tree produced by the {@code Parenthesis}
	 * labeled alternative in {@link exprParser#value}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitParenthesis(exprParser.ParenthesisContext ctx);
}