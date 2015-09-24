Assignment No : Group B(D3)
Assignment Name : Implement Decision trees on Digital Library Data to mirror more titles(PDF) in the library application,
compare it with Na ̈ıve Bayes algorithm.
Class : B.E						Div : B
Roll No : 							Date : 

import java.io.*;

class DecisionTreeApp {

    /* ------------------------------- */
    /*                                 */
    /*              FIELDS             */
    /*                                 */
    /* ------------------------------- */

    static BufferedReader keyboardInput = new
                           BufferedReader(new InputStreamReader(System.in));
    static DecisionTree newTree;

    /* --------------------------------- */
    /*                                   */
    /*               METHODS             */
    /*                                   */
    /* --------------------------------- */

    /* MAIN */

    public static void main(String[] args) throws IOException {

        // Create instance of class DecisionTree

        newTree = new DecisionTree();

        // Generate tree

        generateTree();

        // Output tree

        System.out.println("\nOUTPUT DECISION TREE");
        System.out.println("====================");
        newTree.outputBinTree();

        // Query tree

        queryTree();
        }

    /* GENERATE TREE */

    static void generateTree() {
        System.out.println("\nGENERATE DECISION TREE");
        System.out.println("======================");
        newTree.createRoot(1,"Does Writer is chetan bhagat?");
        newTree.addYesNode(1,2,"Is it a love story?");
        newTree.addNoNode(1,3,"Is it a love story?");
        newTree.addYesNode(2,4,"Book is Half Girlfriend");
        newTree.addNoNode(2,5,"Book is Five Point Someone");
        newTree.addYesNode(3,6,"Book is I Too Had Love Story");
        newTree.addNoNode(3,7,"Wings of Fire");
        }

    /* QUERY TREE */
	
    static void queryTree() throws IOException {
        System.out.println("\nQUERY DECISION TREE");
        System.out.println("===================");
        newTree.queryBinTree();

        // Option to exit

        optionToExit();
        }

    /* OPTION TO EXIT PROGRAM */

    static void optionToExit() throws IOException {
        System.out.println("Exit? (enter \"Yes\" or \"No\")");
        String answer = keyboardInput.readLine();
        if (answer.equals("Yes")) return;
        else {
            if (answer.equals("No")) queryTree();
            else {
                System.out.println("ERROR: Must answer \"Yes\" or \"No\"");
                optionToExit();
                }
            }
        }
    }


class DecisionTree {

    /* ------------------------------- */
    /*                                 */
    /*              FIELDS             */
    /*                                 */
    /* ------------------------------- */

    /* NESTED CLASS */

    private class BinTree {
    	
	/* FIELDS */
	
	private int     nodeID;
    	private String  questOrAns = null;
    	private BinTree yesBranch  = null;
    	private BinTree noBranch   = null;
	
	/* CONSTRUCTOR */
	
	public BinTree(int newNodeID, String newQuestAns) {
	    nodeID     = newNodeID;
	    questOrAns = newQuestAns;
            }
	}

    /* OTHER FIELDS */

    static BufferedReader    keyboardInput = new
                           BufferedReader(new InputStreamReader(System.in));
    BinTree rootNode = null;

    /* ------------------------------------ */
    /*                                      */
    /*              CONSTRUCTORS            */
    /*                                      */
    /* ------------------------------------ */

    /* Default Constructor */

    public DecisionTree() {
	}

    /* ----------------------------------------------- */
    /*                                                 */
    /*               TREE BUILDING METHODS             */
    /*                                                 */
    /* ----------------------------------------------- */

    /* CREATE ROOT NODE */

    public void createRoot(int newNodeID, String newQuestAns) {
	rootNode = new BinTree(newNodeID,newQuestAns);	
	System.out.println("Created root node " + newNodeID);	
	}
			
    /* ADD YES NODE */

    public void addYesNode(int existingNodeID, int newNodeID, String newQuestAns) {
	// If no root node do nothing
	
	if (rootNode == null) {
	    System.out.println("ERROR: No root node!");
	    return;
	    }
	
	// Search tree
	
	if (searchTreeAndAddYesNode(rootNode,existingNodeID,newNodeID,newQuestAns)) {
	    System.out.println("Added node " + newNodeID +
	    		" onto \"yes\" branch of node " + existingNodeID);
	    }
	else System.out.println("Node " + existingNodeID + " not found");
	}

    /* SEARCH TREE AND ADD YES NODE */

    private boolean searchTreeAndAddYesNode(BinTree currentNode,
    			int existingNodeID, int newNodeID, String newQuestAns) {
    	if (currentNode.nodeID == existingNodeID) {
	    // Found node
	    if (currentNode.yesBranch == null) currentNode.yesBranch = new
	    		BinTree(newNodeID,newQuestAns);
	    else {
	        System.out.println("WARNING: Overwriting previous node " +
			"(id = " + currentNode.yesBranch.nodeID +
			") linked to yes branch of node " +
			existingNodeID);
		currentNode.yesBranch = new BinTree(newNodeID,newQuestAns);
		}		
    	    return(true);
	    }
	else {
	    // Try yes branch if it exists
	    if (currentNode.yesBranch != null) { 	
	        if (searchTreeAndAddYesNode(currentNode.yesBranch,
		        	existingNodeID,newNodeID,newQuestAns)) {    	
	            return(true);
		    }	
		else {
    	        // Try no branch if it exists
	    	    if (currentNode.noBranch != null) {
    	    		return(searchTreeAndAddYesNode(currentNode.noBranch,
				existingNodeID,newNodeID,newQuestAns));
			}
		    else return(false);	// Not found here
		    }
    		}
	    return(false);		// Not found here
	    }
   	} 	
    		
    /* ADD NO NODE */

    public void addNoNode(int existingNodeID, int newNodeID, String newQuestAns) {
	// If no root node do nothing
	
	if (rootNode == null) {
	    System.out.println("ERROR: No root node!");
	    return;
	    }
	
	// Search tree
	
	if (searchTreeAndAddNoNode(rootNode,existingNodeID,newNodeID,newQuestAns)) {
	    System.out.println("Added node " + newNodeID +
	    		" onto \"no\" branch of node " + existingNodeID);
	    }
	else System.out.println("Node " + existingNodeID + " not found");
	}
	
    /* SEARCH TREE AND ADD NO NODE */

    private boolean searchTreeAndAddNoNode(BinTree currentNode,
    			int existingNodeID, int newNodeID, String newQuestAns) {
    	if (currentNode.nodeID == existingNodeID) {
	    // Found node
	    if (currentNode.noBranch == null) currentNode.noBranch = new
	    		BinTree(newNodeID,newQuestAns);
	    else {
	        System.out.println("WARNING: Overwriting previous node " +
			"(id = " + currentNode.noBranch.nodeID +
			") linked to yes branch of node " +
			existingNodeID);
		currentNode.noBranch = new BinTree(newNodeID,newQuestAns);
		}		
    	    return(true);
	    }
	else {
	    // Try yes branch if it exists
	    if (currentNode.yesBranch != null) { 	
	        if (searchTreeAndAddNoNode(currentNode.yesBranch,
		        	existingNodeID,newNodeID,newQuestAns)) {    	
	            return(true);
		    }	
		else {
    	        // Try no branch if it exists
	    	    if (currentNode.noBranch != null) {
    	    		return(searchTreeAndAddNoNode(currentNode.noBranch,
				existingNodeID,newNodeID,newQuestAns));
			}
		    else return(false);	// Not found here
		    }
		 }
	    else return(false);	// Not found here
	    }
   	} 	

    /* --------------------------------------------- */
    /*                                               */
    /*               TREE QUERY METHODS             */
    /*                                               */
    /* --------------------------------------------- */

    public void queryBinTree() throws IOException {
        queryBinTree(rootNode);
        }

    private void queryBinTree(BinTree currentNode) throws IOException {

        // Test for leaf node (answer) and missing branches

        if (currentNode.yesBranch==null) {
            if (currentNode.noBranch==null) System.out.println(currentNode.questOrAns);
            else System.out.println("Error: Missing \"Yes\" branch at \"" +
            		currentNode.questOrAns + "\" question");
            return;
            }
        if (currentNode.noBranch==null) {
            System.out.println("Error: Missing \"No\" branch at \"" +
            		currentNode.questOrAns + "\" question");
            return;
            }

        // Question

        askQuestion(currentNode);
        }

    private void askQuestion(BinTree currentNode) throws IOException {
        System.out.println(currentNode.questOrAns + " (enter \"Yes\" or \"No\")");
        String answer = keyboardInput.readLine();
        if (answer.equals("Yes")) queryBinTree(currentNode.yesBranch);
        else {
            if (answer.equals("No")) queryBinTree(currentNode.noBranch);
            else {
                System.out.println("ERROR: Must answer \"Yes\" or \"No\"");
                askQuestion(currentNode);
                }
            }
        }

    /* ----------------------------------------------- */
    /*                                                 */
    /*               TREE OUTPUT METHODS               */
    /*                                                 */
    /* ----------------------------------------------- */

    /* OUTPUT BIN TREE */

    public void outputBinTree() {

        outputBinTree("1",rootNode);
        }

    private void outputBinTree(String tag, BinTree currentNode) {

        // Check for empty node

        if (currentNode == null) return;

        // Output

        System.out.println("[" + tag + "] nodeID = " + currentNode.nodeID +
        		", question/answer = " + currentNode.questOrAns);
        		
        // Go down yes branch

        outputBinTree(tag + ".1",currentNode.yesBranch);

        // Go down no branch

        outputBinTree(tag + ".2",currentNode.noBranch);
	}      		
    }


/* Output

sitrc@sitrc-OptiPlex-390:~$ javac decision.java
sitrc@sitrc-OptiPlex-390:~$ java DecisionTreeApp

GENERATE DECISION TREE
======================
Created root node 1
Added node 2 onto "yes" branch of node 1
Added node 3 onto "no" branch of node 1
Added node 4 onto "yes" branch of node 2
Added node 5 onto "no" branch of node 2
Added node 6 onto "yes" branch of node 3
Added node 7 onto "no" branch of node 3

OUTPUT DECISION TREE
====================
[1] nodeID = 1, question/answer = Does Writer is chetan bhagat?
[1.1] nodeID = 2, question/answer = Is it a love story?
[1.1.1] nodeID = 4, question/answer = Book is Half Girlfriend
[1.1.2] nodeID = 5, question/answer = Book is Five Point Someone
[1.2] nodeID = 3, question/answer = Is it a love story?
[1.2.1] nodeID = 6, question/answer = Book is I Too Had Love Story
[1.2.2] nodeID = 7, question/answer = Wings of Fire

QUERY DECISION TREE
===================
Does Writer is chetan bhagat? (enter "Yes" or "No")
Yes
Is it a love story? (enter "Yes" or "No")
Yes
Book is Half Girlfriend
Exit? (enter "Yes" or "No")
No

QUERY DECISION TREE
===================
Does Writer is chetan bhagat? (enter "Yes" or "No")
No
Is it a love story? (enter "Yes" or "No")
Yes
Book is I Too Had Love Story
Exit? (enter "Yes" or "No")
No

QUERY DECISION TREE
===================
Does Writer is chetan bhagat? (enter "Yes" or "No")
No
Is it a love story? (enter "Yes" or "No")
No
Wings of Fire
Exit? (enter "Yes" or "No")
No

QUERY DECISION TREE
===================
Does Writer is chetan bhagat? (enter "Yes" or "No")
Yes
Is it a love story? (enter "Yes" or "No")
No
Book is Five Point Someone
Exit? (enter "Yes" or "No")
Yes
sitrc@sitrc-OptiPlex-390:~$ 
*/



