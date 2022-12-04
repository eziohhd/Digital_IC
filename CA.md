# Computer Architecture

## Knowledge points

* **A pipeline implements precise exceptions if:**

  * All instructions before the faulting instruction can complete
  * All instructions after (and including) the faulting instruction can safely be restarted
  
* **We need to be able to restart an instruction that causes an exception:**
  * Force an exception handling instruction (e.g., some special routine call to handle the exception) into the pipeline
  * Turn off all writes for the faulting instruction
  * Save the program counter (PC) for the faulting instruction to  be used in return from exception handling
  
* **Solution for simple MIPS**

  * **Need to add control and data-paths to support exceptions and interrupts.** 
  * **When an exception or interrupt occurs, the following must be done:**
    * EPC <= PC
    * Cause <= (cause code for event)
    * Status <= (fault)
    * PC <= (handler address)
  * **To return from an exception or data-path, the following must be done:**
    * PC <= EPC
    * Status <= (fault clear)
  
* **Hazards**
  * Structural hazards
  * Data hazards
  * Control hazards
  
* **Scoreboard pipeline**
  * **Goal of score-boarding** is to maintain an execution rate of CPI=1 by executing an instruction as early as possible
  * **Instructions execute out-of-order** when there are sufficient resources and no data dependencies
  * **A scoreboard is a hardware unit that keeps track of**
    * the **instructions** that are in the process of being executed
    * the **functional units** that are doing the executing
    * and the **registers** that will hold the results of those units
  * A scoreboard centrally performs all hazard detection and instruction control

* **Scoreboard functionality**
  * **Issue**: An instruction is issued if (**in order**):
    * The needed functional unit is free (there is no **structural hazard**)
    * No functional unit has a destination operand equal to the destination of the instruction (resolves **WAW hazards**)
  * **Read:** Wait until no data hazards, then read operands
    * Performed in parallel for all functional units
    * Resolves **RAW hazards** dynamically
  * **EX:** Normal execution (**out of order**)
    * Notify the scoreboard when ready
  * **Write:** The instruction can update destination if:
    * All earlier instructions have read their operands (resolves **WAR hazards**)

* **Three stages of Tomasulo algorithm**

  * **Issue –** get instruction from instruction Queue

    • If matching reservation station free (no **structural hazard**)

    • Instruction is issued together with its operand's values or RS point (**register rename**, handle **WAR, WAW**)

  * **Execution –** operate on operands (EX)

    • When both operands are ready, then execute (handle **RAW**)

    • If not ready, watch **Common Data Bus (CDB)** for operands (snooping)

  * **Write result –** finish execution (WB)

    • Write on CDB to all awaiting RS, regs (**forwarding**)

    • Mark reservation station available

    • Data Bus

    * Normal Bus: data + destination

    * Common Data Bus: data + source (snooping)
  
 * **Hardware-base speculation**

   * Trying to exploit more ILP (e.g., multiple issue) while maintaining control dependencies becomes a burden
   * Overcome control dependencies
     * By speculating on the outcome of branches and executing the program as if our guesses were correct
     * Need to handle incorrect guesses
   * Methodologies (combine):
     * <u>Dynamic branch prediction</u>: allows instruction scheduling across branches (choose which instr. to execute)
     * <u>Speculation</u>: execute instructions before all control dependencies are resolved
     * <u>Dynamic scheduling</u>: take advantage of ILP (scheduling speculated instr.)

* **Implementing speculation**

  * **Key idea**

    • Allow instructions to execute **out of order** 

    • Force instructions to **commit in order**

    • Prevent any **irrevocable action** (such as updating state or taking an exception) until an instruction commits 

  * **Strategies**

    • Must separate bypassing of results among instructions from actual completion (write-back) of instructions
    • Instruction commit updates register or memory when instruction no longer speculative

  * **Need to add** **re-order buffer**

    • Hold the results of inst. that have finished exe but have not committed

* **Four-step speculation**

  * **Issue**
    • Get instruction from instruction queue and issue if reservation station and **ROB slots** available – sometimes called dispatch 
    • Send operands or **ROB entry # (instead of RS #)**
    
  * **Execution – operate on operands (EX)**
    • If both operands ready: execute; if not, watch CDB for result;
    • When both operands are in reservation station: execute
    
  * **Write result – complete execution** 
    • Write on CDB to all awaiting **FUs (RSs) & ROB** (tagged by **ROB entry** #)
    • Mark reservation station available
    
  * **Commit – update register with reorder result**
  
    • When instr. **is at head of ROB & result is present & no longer speculative**; update register with result (or store to memory) and  remove instr. from ROB; 
  
    • handle mis-speculations and precise exceptions

