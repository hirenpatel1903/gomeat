<?php

if (! function_exists('envUpdate')) {
    
    function envUpdate($key,$value)
    {
        $path = base_path('.env');

        if (file_exists($path)) {

            file_put_contents($path, str_replace(
                $key . '=' . env($key), $key . '=' . $value, file_get_contents($path)
            ));
        }
    }
}


if (! function_exists('dbConnection')) {
    
    function dbConnection()
    {
        $result = false;
        try {
            DB::connection()->getPdo();

                $databaseName = \DB::connection()->getDatabaseName();
                if($databaseName!=""){
                    return true;
                }
                else {
                    return false;
                }
        } catch (Exception $e) {
           return false;
        }
    }
}