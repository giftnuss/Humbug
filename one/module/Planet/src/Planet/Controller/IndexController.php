<?php

namespace Planet\Controller;

use Zend\Mvc\Controller\AbstractActionController;
use Zend\View\Model\ViewModel;

class IndexController extends AbstractActionController
{
    public function indexAction()
    {
        $services = $this->getServiceLocator();
        $planet = $services->get('Planet');
        print_r($planet->getConfig());
        $view = new ViewModel();
        return $view;
    }
}
