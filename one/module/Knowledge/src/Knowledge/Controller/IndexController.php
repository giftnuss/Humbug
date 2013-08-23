<?php

namespace Knowledge\Controller;

use Zend\Mvc\Controller\AbstractActionController;
use Zend\View\Model\ViewModel;

class IndexController extends AbstractActionController
{
    public function indexAction()
    {
        $view = new ViewModel();
        $topicform = new \Knowledge\Form\Topic();
        $view->topicform = $topicform;
        $view->scopeform = new \Knowledge\Form\Scope();
        return $view;
    }
}
