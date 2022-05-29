<?php

namespace App\Http\Controllers\Admin;

use Illuminate\Http\Request;
use App\YourExport;
use Maatwebsite\Excel\Facades\Excel;
use App\Imports\ImportProducts;
use App\Http\Controllers\Controller;
use DB;
use Session;
use Hash;
use App\Models\Admin;
use Auth;

class ImportExcelController extends Controller
{
     public function bulkupcity(Request $request)
    {
        $title = "Bulk Upload Cities and Area";
          $admin_email=Auth::guard('admin')->user()->email;
    	$admin= DB::table('admin')
    	         ->leftJoin('roles','admin.role_id','=','roles.role_id')
    	 		 ->where('admin.email',$admin_email)
    	 		   ->first();
    	  $logo = DB::table('tbl_web_setting')
                ->where('set_id', '1')
                ->first();
        
          
    	return view('admin.city.bulkuploadcity', compact('title',"admin", "logo"));
    }
    
         public function importcity(Request $request)
    {
       $this->validate(
            $request,
                [
                    
                    'select_file' => 'required'
                ],
                [
                    'select_file.required' => 'choose a csv file.'
                ]
        );
          $count=0;
            $fp = fopen($_FILES['select_file']['tmp_name'],'r') or die("can't open file");
            while($csv_line = fgetcsv($fp,1024))
            {
                $count++;
                if($count == 1)
                {
                    continue;
                }//keep this if condition if you want to remove the first row
                for($i = 0, $j = count($csv_line); $i < $j; $i++)
                {

                    $insert_csv0 = array();
                    $insert_csv0['city_name'] =  ucfirst($csv_line[0]);
                 
                    
                    
                    
                   
                }
                $i++;
                $data = array(
                    'city_name' => $insert_csv0['city_name']
                    );
                
                $inserted = DB::table('city')->insertGetId($data);
               
                
                // var_dump($inserted);
            }
            fclose($fp) or die("can't close file");
          return back()->with('success', trans('keywords.Cities imported successfully'));
            return $data;
        // var_dump($inserted1);
   } 
   
         public function importsociety(Request $request)
    {
       $this->validate(
            $request,
                [
                    
                    'select_file' => 'required'
                ],
                [
                    'select_file.required' => 'choose a csv file.'
                ]
        );
          $count=0;
            $fp = fopen($_FILES['select_file']['tmp_name'],'r') or die("can't open file");
            while($csv_line = fgetcsv($fp,1024))
            {
                $count++;
                if($count == 1)
                {
                    continue;
                }//keep this if condition if you want to remove the first row
                for($i = 0, $j = count($csv_line); $i < $j; $i++)
                {

                    $insert_csv0 = array();
                    $insert_csv0['society_name'] = ucfirst($csv_line[0]);
                    $insert_csv1['city_id'] = $csv_line[1];

                }
                $i++;
                $data = array(
                    'society_name' => $insert_csv0['society_name'],
                    'city_id' =>$insert_csv1['city_id']
                    );
                
                $inserted = DB::table('society')->insertGetId($data);
               
                
                // var_dump($inserted);
            }
            fclose($fp) or die("can't close file");
          return back()->with('success', trans('keywords.Societies imported successfully'));
            return $data;
        // var_dump($inserted1);
   } 
   
    
   
   public function bulkup(Request $request)
    {
        $title = "Bulk Upload products and varients";
          $admin_email=Auth::guard('admin')->user()->email;
    	 $admin= DB::table('admin')
    	         ->leftJoin('roles','admin.role_id','=','roles.role_id')
    	 		 ->where('admin.email',$admin_email)
    	 		   ->first();
    	  $logo = DB::table('tbl_web_setting')
                ->where('set_id', '1')
                ->first();
        
          
    	return view('admin.product.bulkupload', compact('title',"admin", "logo"));
    }
    
        public function import(Request $request)
    {
       $this->validate(
            $request,
                [
                    
                    'select_file' => 'required'
                ],
                [
                    'select_file.required' => 'choose a csv file.'
                ]
        );
          $count=0;
            $fp = fopen($_FILES['select_file']['tmp_name'],'r') or die("can't open file");
            while($csv_line = fgetcsv($fp,1024))
            {
                $count++;
                if($count == 1)
                {
                    continue;
                }//keep this if condition if you want to remove the first row
                for($i = 0, $j = count($csv_line); $i < $j; $i++)
                {

                    $insert_csv0 = array();
                    $insert_csv0['cat_id'] = $csv_line[0];
                    $insert_csv0['product_name'] = $csv_line[1];
                    $insert_csv0['product_image'] = $csv_line[2];
                    
                    
                     $insert_csv1 = array();
                    $insert_csv1['quantity'] = $csv_line[3];
                    $insert_csv1['unit'] = $csv_line[4];
                    $insert_csv1['base_mrp'] = $csv_line[5];
                    $insert_csv1['base_price'] = $csv_line[6];
                    $insert_csv1['description'] = $csv_line[7];
                    $insert_csv1['ean'] = $csv_line[8];
                   
                }
                $i++;
                $data = array(
                    'cat_id' => $insert_csv0['cat_id'],
                    'product_name' => $insert_csv0['product_name'],
                    'product_image' =>  'images/products/'.$insert_csv0['product_image'],
                    
                    );
                
                $inserted = DB::table('product')->insertGetId($data);
                 $data1 = array(
                     'product_id'=>$inserted,
                    'quantity' => $insert_csv1['quantity'],
                    'unit' => $insert_csv1['unit'],
                    'base_mrp' => $insert_csv1['base_mrp'],
                    'base_price' => $insert_csv1['base_price'],
                    'description' => $insert_csv1['description']
                    );   
                $inserted1 = DB::table('product_varient')->insertGetId($data1);


                 $tags = explode(",", $csv_line[9]);
             foreach($tags as $tag){
             DB::table('tags')
            ->insertGetId([
                'product_id'=>$inserted,
                'tag'=>$tag
            ]);      
             }   
                // var_dump($inserted);
            }
            fclose($fp) or die("can't close file");
          return back()->with('success', trans('keywords.Products imported successfully'));
            return $data;
        // var_dump($inserted1);
   } 
    
    
    
        public function import_varients(Request $request)
    {
          $this->validate(
            $request,
                [
                    
                    'select_file' => 'required'
                ],
                [
                    'select_file.required' => 'choose a csv file.'
                ]
        );
          $count=0;
            $fp = fopen($_FILES['select_file']['tmp_name'],'r') or die("can't open file");
            while($csv_line = fgetcsv($fp,1024))
            {
                $count++;
                if($count == 1)
                {
                    continue;
                }//keep this if condition if you want to remove the first row
                for($i = 0, $j = count($csv_line); $i < $j; $i++)
                {
                    $insert_csv1 = array();
                    $insert_csv1['product_id'] = $csv_line[0];
                    $insert_csv1['quantity'] = $csv_line[1];
                    $insert_csv1['unit'] = $csv_line[2];
                    $insert_csv1['base_mrp'] = $csv_line[3];
                    $insert_csv1['base_price'] = $csv_line[4];
                    $insert_csv1['description'] = $csv_line[5];
                    $insert_csv1['ean'] = $csv_line[6];
                   
                }
                $i++;
                
                 $data1 = array(
                     'product_id'=>$insert_csv1['product_id'],
                    'quantity' => $insert_csv1['quantity'],
                    'unit' => $insert_csv1['unit'],
                    'base_mrp' => $insert_csv1['base_mrp'],
                    'base_price' => $insert_csv1['base_price'],
                    'description' => $insert_csv1['description'],
                    );   
                $inserted1 = DB::table('product_varient')->insertGetId($data1);

              
        }
            fclose($fp) or die("can't close file");
          return back()->with('success', trans('keywords.Products Varient successfully'));
            return $data;
        // var_dump($inserted1);
   } 
    

}
