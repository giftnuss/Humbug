<?php

namespace Pea\Form;

use Zend\View\Renderer\RendererInterface as Renderer;

class Form extends \Zend\Form\Form
{
    public function __construct($name = null, $options = array())
    {
        parent::__construct($name,$options);
        $this->setAttribute('method', 'post');
        $this->setupForm();
    }
    
    public function setupForm()
    {
        // override this
    }
    
    public function display(Renderer $view)
    {
        echo $this->render($view);		
	}

    public function render(Renderer $view)
    {
		$out = $view->form()->openTag($this) . "\n";
		$out .= $view->formCollection($this) . "\n";
		$out .= $view->form()->closeTag($this) . "\n";
		return $out;
	}
}
