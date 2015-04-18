--============================================================================
--!
--! \file      example_package
--!
--! \project   libhdl
--!
--! \author    Andreas Muller
--!
--! \date      2015-04-20
--!
--! \version   1.0
--!
--! \brief     Brief package description in one or two sentences.
--!
--! \details   More detailed description. This should focus on the kind of
--!            functions, procedures and operators which are offered by the
--!            package.
--!
--! \bug       No bugs or known issues.
--!
--! \see       List of references useful for the understanding of this
--!            package e.g. standards, RFCs, papers, book chapters, web links
--!            &cetera.
--!
--! \copyright Copyright (C) 2015, Andreas Muller
--!            GNU General Public License Version 2
--!
--!            This program is free software; you can redistribute it and/or
--!            modify it under the terms of the GNU General Public License as
--!            published by the Free Software Foundation; either version 2 of
--!            the License, or (at your option) any later version.
--!            This program is distributed in the hope that it will be useful,
--!            but WITHOUT ANY WARRANTY; without even the implied warranty of
--!            MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
--!            GNU General Public License for more details.
--!
--============================================================================


library ieee;
    use ieee.numeric_std.all;
    use ieee.std_logic_1164.all;

package template_package is
    constant MY_WORD_WIDTH : integer := 12;
    subtype t_my_word is std_logic_vector(MY_WORD_WIDTH-1 downto 0);
    
    type t_my_answers is (YES, NO, MAYBE, GLURPNARD);
    
    type t_my_saying is record
        unique_id : integer;
        word      : t_my_word;
        some_bits : bit_vector(3 downto 0);
    end record;
    
    function "+"(op1 : t_my_word; op2 : t_my_word) return t_my_word;
    
    procedure equalZero(signal op : in t_my_word; signal result : out boolean);
end package template_package;


library ieee;
    use ieee.numeric_std.all;
    use ieee.std_logic_1164.all;

package body template_package is
    function "+"(op1 : t_my_word; op2 : t_my_word) return t_my_word is
        variable reval : t_my_word;
    begin
        reval := std_logic_vector(unsigned(op1) + unsigned(op2));
        return reval;
    end function "+";
    
    procedure equalZero(signal op : in t_my_word; signal result : out boolean) is
        constant ZERO_WORD : t_my_word := (others => '0');
    begin
        result <= (op = ZERO_WORD);
    end procedure equalZero;
end package body template_package;
