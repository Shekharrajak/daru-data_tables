## 0.3.5 (2017-12-03)

**Enhancements:**

- Load large set of data #20

- Renmaed to `Daru::View::DataTable.new(data, options)` from
`Daru::DataTables::DataTable.new(data, options)` #23

- Remove bunch of js lines in rails #23 :

Include js in rails app/assets/javascripts/application.js file as:

```
//= require jquery-latest.min
//= require jquery.dataTables

```
CSS files can be included as:

```
 *= require jquery.dataTables
```

**Note:**

* [GSoC 2018 project](https://github.com/SciRuby/daru-view/wiki/GSoC-2018---Progress-Report)

* [Wiki page about loading large set in daru-view using daru-data_tables](https://github.com/SciRuby/daru-view/wiki/DataTables-to-load-large-set-data-in-daru-view-table)

## 0.1.0 (2017-09-20)

**Features:**

- [Discussion at datatables forum](https://github.com/Shekharrajak/daru-data_tables/wiki/Discussion-in-datatables-forum)

**NOTE:**


- [GSoC 2017 Blog post](http://shekharrajak.github.io/gsoc_2017_posts/)

- [Blog post at SciRuby, how daru-data_table gem is used in daru-view](http://sciruby.com/blog/2017/09/01/gsoc-2017-data-visualization-using-daru-view/)
