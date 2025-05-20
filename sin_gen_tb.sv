<br><br><br><pre><code>stored_file Object
(
    [fs:stored_file:private] => file_storage Object
        (
            [tempdir:file_storage:private] => /var/www/moodle/temp/hu23/filestorage
            [filesystem:file_storage:private] => file_system_filedir Object
                (
                    [filedir:protected] => /cs/wwwdata/moodles/hu23/filedir
                    [trashdir:protected] => /cs/wwwdata/moodles/hu23/trashdir
                    [dirpermissions:protected] => 1535
                    [filepermissions:protected] => 438
                )

        )

    [file_record:stored_file:private] => stdClass Object
        (
            [id] => 16153473
            [contenthash] => 952fd4af6b73495995c1230dfda276a8562c4c4a
            [pathnamehash] => 69e32c7de6d3f8dbd27729dbd26b52cdd20f63bc
            [contextid] => 426433
            [component] => assignsubmission_file
            [filearea] => submission_files
            [itemid] => 463813
            [filepath] => /
            [filename] => sin_gen_tb.sv.sv
            [userid] => 772168
            [filesize] => 1033
            [mimetype] => text/plain
            [status] => 0
            [source] => sin_gen_tb.sv.sv
            [author] => בנימין ג'ייז
            [license] => allrightsreserved
            [timecreated] => 1712673509
            [timemodified] => 1712673554
            [sortorder] => 0
            [referencefileid] => 
            [repositoryid] => 
            [reference] => 
            [referencelastsync] => 
        )

    [repository:stored_file:private] => 
    [filesystem:stored_file:private] => file_system_filedir Object
        (
            [filedir:protected] => /cs/wwwdata/moodles/hu23/filedir
            [trashdir:protected] => /cs/wwwdata/moodles/hu23/trashdir
            [dirpermissions:protected] => 1535
            [filepermissions:protected] => 438
        )

)
</code></pre>`timescale 1ns/1ns

module sin_gen_tb();

logic clk_tb, resetb_tb, en_tb ;
logic [7:0] period_sel_tb ;
logic [8:0] out_tb ;


sin_gen dut (
    .clk(clk_tb) ,
    .resetb(resetb_tb) ,
    .en(en_tb),
    .period_sel(period_sel_tb) ,
    .out(out_tb) 
    );


//clock 500[MHz]
initial begin
    clk_tb = 1'b1;
    forever begin
        #1ns  
        clk_tb = ~clk_tb; 
    end 
end



////////////////////////////////////////////////////////////////////////////////////////////////////
// reset at the start of the simulation
initial begin 
	resetb_tb = 1'b1;
	#20ns;
	resetb_tb = 1'b0;
	#10ns;
	resetb_tb = 1'b1;
end


// driving the signals

initial begin 
	en_tb = 1'b0;
	period_sel_tb = 8'b0;
	#20ns;
	en_tb = 1'b1;
	#10ns;
	en_tb = 1'b0;
	#2200ns;
  	en_tb = 1'b1;
	#1000ns;
	period_sel_tb = 8'b1;
	#2000ns;
	period_sel_tb = 8'b0;
	

end
//////////////////////////////////////////////////////////////////////////////////////////////////////


endmodule//sin_gen_tb
