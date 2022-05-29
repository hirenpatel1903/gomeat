<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;



class DbInstallSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        //dd('here');
        $path = public_path('dbdump/database.sql');
        $sql = file_get_contents($path);
        DB::unprepared($sql);
    }
}
